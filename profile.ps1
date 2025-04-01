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
    Write-Host ("`n$Env:UserName at $Env:UserDomain ") `
        -NoNewline -ForegroundColor Cyan
    Write-Host ("  $($executionContext.SessionState.Path.CurrentLocation) ") `
        -NoNewline -ForegroundColor Magenta
    Write-Host ("$(Get-GitBranch)") -NoNewline -ForegroundColor DarkGray
    if ($Env:CONDA_PROMPT_MODIFIER) {
        $Env:CONDA_PROMPT_MODIFIER | Write-Host -ForegroundColor Green
    }
    Write-Host (" ↪$('>' * ($nestedPromptLevel))") `
        -NoNewline -ForegroundColor Yellow
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
