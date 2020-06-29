function prompt {
    $color = if ($?) { 'green' } else { 'red' }
    Write-Host 'PS ' -nonewline

    $regex = [regex]::Escape($HOME) + "(\\.*)*$"
    $pwd = "$($pwd -replace $regex, '~$1')"

    Write-Host $pwd -fore blue -nonewline

    Write-Host "`n->" -fore $color -nonewline
    return ' '
}

Set-Alias e explorer
Set-Alias grep Select-String
Set-Alias py python

Set-PSReadLineKeyHandler -Chord Ctrl+w -Function ViExit
Set-PSReadLineKeyHandler -Chord Ctrl+d -Function ViExit

function fm($file) {
    Invoke-Expression "astyle -A2s4SpHUk3W3xfxhOn $file"
}

Remove-Item Alias:cls
function cls {
Clear-Host
echo "                   _____    __                       __            ___   ____     ____     ___
                  / ___/   / /_     ___     _____   / /  __  __   <  /  / __ \   / __ \   <  /
                  \__ \   / __ \   / _ \   / ___/  / /  / / / /   / /  / / / /  / / / /   / / 
                 ___/ /  / / / /  /  __/  / /     / /  / /_/ /   / /  / /_/ /  / /_/ /   / /  
                /____/  /_/ /_/   \___/  /_/     /_/   \__, /   /_/   \____/   \____/   /_/   
                                                      /____/                                  "
}

echo "                   _____    __                       __            ___   ____     ____     ___
                  / ___/   / /_     ___     _____   / /  __  __   <  /  / __ \   / __ \   <  /
                  \__ \   / __ \   / _ \   / ___/  / /  / / / /   / /  / / / /  / / / /   / / 
                 ___/ /  / / / /  /  __/  / /     / /  / /_/ /   / /  / /_/ /  / /_/ /   / /  
                /____/  /_/ /_/   \___/  /_/     /_/   \__, /   /_/   \____/   \____/   /_/   
                                                      /____/                                  "