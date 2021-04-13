$logFileName = "~/dotfiles-install-ps1.log"
Write-Verbose 'Starting install.ps1' -Verbose 4>&1 > $logFileName

$configPath = Join-Path $PSScriptRoot '.config'

$homeConfigPath = Join-Path '~' '.config'
if (Test-Path -Path $homeConfigPath -PathType Container) {
    Write-Verbose "Directory $homeConfigPath exists" -Verbose 4>&1 > $logFileName
} else {
    Write-Verbose "Directory $homeConfigPath does not exist" -Verbose 4>&1 > $logFileName
    New-Item -Path $homeConfigPath -ItemType Directory -Verbose 2>&1 4>&1 >> $logFileName
}

# Set up symlinks
Get-ChildItem -Path $configPath | ForEach-Object {
    $path = Join-Path $homeConfigPath $_.Name
    Write-Verbose "Creating symlink from $path to $($_.FullName)" -Verbose 4>&1 >> $logFileName
    New-Item -Path $path -ItemType SymbolicLink -Value $_.FullName -Verbose 2>&1 4>&1 >> $logFileName
    Write-Verbose '-----' -Verbose 4>&1 >> $logFileName
    Get-ChildItem -Path $homeConfigPath >> $logFileName
    Write-Verbose '-----' -Verbose 4>&1 >> $logFileName
}

Install-Module PSDepend -Force -Verbose 4>&1 >> $logFileName
Invoke-PSDepend -Force (Join-Path $PSScriptRoot 'requirements.psd1') -Verbose 4>&1 >> $logFileName

Write-Verbose '-----' -Verbose 4>&1 >> $logFileName
Get-ChildItem -Path ~/.config >> $logFileName
Write-Verbose '-----' -Verbose 4>&1 >> $logFileName
Write-Verbose 'Exiting install.ps1' -Verbose 4>&1 >> $logFileName
