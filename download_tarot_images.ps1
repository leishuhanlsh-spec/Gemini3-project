$baseUrl = "https://sacred-texts.com/tarot/pkt/img/"
$outputDir = "tarot_images"

# Create directory if it doesn't exist
if (-not (Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
    Write-Host "Created directory: $outputDir"
}

$suits = @("wa", "cu", "sw", "pe")

for ($i = 0; $i -lt 78; $i++) {
    $filename = ""
    
    if ($i -lt 22) {
        # Major Arcana
        $filename = "ar{0:D2}.jpg" -f $i
    } else {
        # Minor Arcana
        $relativeIdx = $i - 22
        $suitIdx = [math]::Floor($relativeIdx / 14)
        $cardVal = ($relativeIdx % 14) + 1
        $prefix = $suits[$suitIdx]
        $filename = "{0}{1:D2}.jpg" -f $prefix, $cardVal
    }

    $url = "$baseUrl$filename"
    $outputPath = Join-Path -Path $outputDir -ChildPath $filename
    
    Write-Host "Downloading $filename..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $outputPath -UserAgent "Mozilla/5.0"
    } catch {
        Write-Error "Failed to download $filename : $_"
    }
    
    # Be nice to the server
    Start-Sleep -Milliseconds 100
}

Write-Host "Download complete!"
