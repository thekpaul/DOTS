# $profile.CurrentUserAllHosts: Save in `~\Documents\PowerShell\profile.ps1`
# NOTE: Windows Powershell (Default, v1.0) uses profiles saved in the
#   `~\Documents\WindowsPowerShell\` directory, where this script may be
#   incompatible - use at your own risk!

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$env:USERPROFILE\miniconda3\Scripts\conda.exe") {
    (& "$env:USERPROFILE\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}
#endregion

# Override `ls` builtin alias for `Get-ChildItem` with avaiable tools, if any
If (Get-Command "eza" -ErrorAction SilentlyContinue) {
    Set-Alias -Name exa -Value eza

    If (Get-Alias ls -ErrorAction SilentlyContinue) {
        Remove-Alias -Name ls -Force
        Set-Alias -Name ls -Value eza -Description "Overridden by 'eza'"
    }

    function lsa {
        eza -AX --group-directories-first --color=auto --icons=auto `
            -I "ntuser*|NTUSER*|desktop.ini" @args
    }

    function tree {
        lsa --tree -l --time-style "+%y/%m/%d %H:%M" @args
    }

    function lscd {
        cd @args; lsa
    }
} Elseif (Test-Path "C:\msys64") {
    If (Get-Command "ls.exe" -ErrorAction SilentlyContinue) {
        If (Get-Alias ls -ErrorAction SilentlyContinue) {
            Remove-Alias -Name ls -Force
        }

        function lsa {
            C:\msys64\usr\bin\ls.exe `
                -AH --group-directories-first --color=auto @args
        }

        function lscd {
            cd @args; lsa
        }
    }
}

function Get-GitBranch () {
    $branch = git rev-parse --abbrev-ref HEAD

    if ($?) { # Inside Git repo -> `$branch` is populated
        if ($branch -eq "HEAD") {
            # Print short-form commit SHA if in detached HEAD state
            $branch = git rev-parse --short HEAD
        } else {
            # APPEND short-form commit SHA to branch/tag with minor formatting
            $branch = $branch + " at " + (git rev-parse --short HEAD)
        }
        return "[  $branch ] "
    } else {
        return ""
    }
}

function Pwsh-Greeting () {
    $uptime = New-Object -TypeName System.Text.StringBuilder

    if ((Get-Uptime).Days) {
        $null = $uptime.Append("$((Get-Uptime).Days) days, ")
    }
    if((Get-Uptime).Hours) {
        $null = $uptime.Append("$((Get-Uptime).Hours) hours, ")
    }
    if ((Get-Uptime).Minutes) {
        $null = $uptime.Append("$((Get-Uptime).Minutes) minutes")
    }

    if ($uptime.Length) {
        return $uptime.ToString() + "...Something on Your Mind?"
    } else {
        return "Less than a minute...Something on Your Mind?"
    }

}

function prompt {
    $oc = $host.ui.RawUI.ForegroundColor # Save text color
    $culture = [cultureinfo]::CurrentCulture # Save session locale settings

    # First List: Username, host machine, Git branch name (if applicable)
    Write-Host ("`n$Env:UserName at $Env:UserDomain ") `
        -NoNewline -ForegroundColor Cyan
    Write-Host ("  $($executionContext.SessionState.Path.CurrentLocation) ") `
        -NoNewline -ForegroundColor Magenta
    Write-Host ("$(Get-GitBranch)") -ForegroundColor DarkGray

    # Second Line: Input indicator, (right-flushed) Conda Env. and current time
    Write-Host (" ↪$('>' * ($nestedPromptLevel))") `
        -NoNewline -ForegroundColor Yellow

    # Right-flushed prompt cursor setup
    $curr_time = "$([cultureinfo]::CurrentCulture = 'en-US'; Get-Date -UFormat '+%H:%M [%d %h (%a)]')"
    $startposx = $Host.UI.RawUI.windowsize.width - $curr_time.length
    $startposy = $Host.UI.RawUI.CursorPosition.Y
    if ($Env:CONDA_PROMPT_MODIFIER) {
        $startposx = $startposx - $Env:CONDA_PROMPT_MODIFIER.length
    }
    $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $startposx,$startposy

    # Print right-flushed prompt
    if ($Env:CONDA_PROMPT_MODIFIER) {
        $Host.UI.RawUI.ForegroundColor = "Green"
        $Host.UI.Write($Env:CONDA_PROMPT_MODIFIER)
    }
    $Host.UI.RawUI.ForegroundColor = "DarkGray"
    $Host.UI.Write($curr_time)

    # Reset prompt conditions for commandline entry
    $host.UI.RawUI.ForegroundColor = $oc # Restore text color
    [cultureinfo]::CurrentCulture = $culture # Restore sesstion locale settings
    $startposx = " ↪$('>' * ($nestedPromptLevel))".length # Compute correct coordinates for commandline entry
    $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $startposx,$startposy

    return " "
}

# Print greeting message first
Write-Host ($(Pwsh-Greeting))

# PSReadLine module import & Prefixed history search
if ($host.Name -eq 'ConsoleHost')
{
    if (Get-Module -ListAvailable -Name PSReadLine)
    {
        Import-Module PSReadLine # Module is installed in current directory

        # Binding for moving through history by prefix
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    }

    if (Get-Module -ListAvailable -Name PSFzf)
    {
        Import-Module PSFzf

        # Override PSReadLine's history search
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                        -PSReadlineChordReverseHistory 'Ctrl+r'

        # Override default tab completion
        Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
    }
}
