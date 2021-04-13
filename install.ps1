$logFileName = "~/dotfiles-install-ps1.log"
Write-Verbose 'Starting install.ps1' -Verbose 4>&1 > $logFileName

$configPath = (Join-Path $PSScriptRoot '.config')

# Set up symlinks
Get-ChildItem -Path $configPath | ForEach-Object {
    $path = Join-Path '~/.config' $_.Name
    Write-Verbose "Creating symlink from $path to $($_.FullName)" -Verbose 4>&1 >> $logFileName
    New-Item -Path $path -ItemType SymbolicLink -Value $_.FullName -Verbose 4>&1 >> $logFileName
}

Install-Module PSDepend -Force -Verbose 4>&1 >> $logFileName
Invoke-PSDepend -Force (Join-Path $PSScriptRoot 'requirements.psd1') -Verbose 4>&1 >> $logFileName

Write-Verbose 'Exiting install.ps1' -Verbose 4>&1 >> $logFileName
