# $profile.CurrentUserAllHosts: Save in `~\Documents\PowerShell\profile.ps1`
# NOTE: Windows Powershell (Default, v1.0) uses profiles saved in the
#   `~\Documents\WindowsPowerShell\` directory, where this script may be
#   incompatible - use at your own risk!

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

function prompt {
    Write-Host ("`n$Env:UserName at $Env:UserDomain ") `
        -NoNewline -ForegroundColor Cyan
    Write-Host ("  $($executionContext.SessionState.Path.CurrentLocation) ") `
        -NoNewline -ForegroundColor Magenta
    Write-Host ("$(Get-GitBranch)") -NoNewline -ForegroundColor DarkGray
    Write-Host (" ↪$('>' * ($nestedPromptLevel))") `
        -NoNewline -ForegroundColor Yellow
    return " "
}
