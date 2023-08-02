# $profile.CurrentUserAllHosts: Save in `$HOME\Documents\PowerShell\profile.ps1`
# NOTE: Windows Powershell (Default, v1.0) uses profiles saved in the
#   `$HOME\Documents\WindowsPowerShell\` directory, where this script may be
#   incompatible - use at your own risk!

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "C:\Users\thekp\miniconda3\Scripts\conda.exe") {
    (& "C:\Users\thekp\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}
#endregion

function prompt {
    Write-Host ("$Env:UserName at $Env:UserDomain ") -NoNewline -ForegroundColor Cyan
    Write-Host ("  $($executionContext.SessionState.Path.CurrentLocation) ") -NoNewline `
        -ForegroundColor Magenta
    if ($Env:CONDA_PROMPT_MODIFIER) {
        $Env:CONDA_PROMPT_MODIFIER | Write-Host -ForegroundColor Green
    }
    Write-Host (" ↪$('>' * ($nestedPromptLevel))") -NoNewline -ForegroundColor Yellow
    return " "
}
