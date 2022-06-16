Param (
    [Parameter(Mandatory=$true)]
    [string]$RootPath
)

Push-Location $RootPath

function DnExampleZipIfFilesUnAvailable {
    Param($DestPath, $URL)
    if (Test-Path -Path "$DestPath" -PathType Container) {} else {
        New-Item -Path "$DestPath" -ItemType Directory
        Invoke-WebRequest -Uri $URL -OutFile "$DestPath.zip"
        Expand-Archive -Path "$DestPath.zip" -DestinationPath "$DestPath"
        Remove-Item "$DestPath.zip"
    }
} 

# Refer to "include" AND "collections" property in _config.yml
DnExampleZipIfFilesUnAvailable -DestPath "$pwd/src/pages" -URL https://raw.githubusercontent.com/lalishansh/Example-Assets/main/Blacklily/_pages.zip
DnExampleZipIfFilesUnAvailable -DestPath "$pwd/src/collections/_blogs" -URL https://raw.githubusercontent.com/lalishansh/Example-Assets/main/Blacklily/_blogs.zip
DnExampleZipIfFilesUnAvailable -DestPath "$pwd/src/collections/_posts" -URL https://raw.githubusercontent.com/lalishansh/Example-Assets/main/Blacklily/_posts.zip

Pop-Location