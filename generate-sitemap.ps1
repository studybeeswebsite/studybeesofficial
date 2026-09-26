# ================================
# StudyBees Sitemap Generator
# ================================

$BaseUrl = "https://studybeesofficial.com"

# The folder where this script is located
$RootFolder = $PSScriptRoot

# Find every HTML file inside this folder and all subfolders
$Files = Get-ChildItem -Path $RootFolder -Filter "*.html" -File -Recurse

# Start the XML sitemap
$Sitemap = @()
$Sitemap += '<?xml version="1.0" encoding="UTF-8"?>'
$Sitemap += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

foreach ($File in $Files) {

    # Get the path relative to the website root
    $RelativePath = $File.FullName.Substring($RootFolder.Length)

    # Convert Windows backslashes to web slashes
    $RelativePath = $RelativePath -replace '\\', '/'

    # Remove the leading slash if necessary
    $RelativePath = $RelativePath.TrimStart('/')

    # Convert special characters into valid XML
    $RelativePath = [System.Security.SecurityElement]::Escape($RelativePath)

    # Add the URL
    $Sitemap += "  <url>"
    $Sitemap += "    <loc>$BaseUrl/$RelativePath</loc>"
    $Sitemap += "  </url>"
}

$Sitemap += '</urlset>'

# Save sitemap.xml in the website's root folder
$OutputFile = Join-Path $RootFolder "sitemap.xml"

$Sitemap -join "`r`n" | Out-File -FilePath $OutputFile -Encoding utf8

Write-Host ""
Write-Host "========================================"
Write-Host "SITEMAP CREATED SUCCESSFULLY!"
Write-Host "========================================"
Write-Host "HTML pages found: $($Files.Count)"
Write-Host "Sitemap location: $OutputFile"
Write-Host ""
Write-Host "Done!"