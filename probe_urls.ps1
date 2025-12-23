$baseUrl = "https://sacred-texts.com/tarot/pkt/img/"
$candidates = @("wa01.jpg", "waac.jpg", "wace.jpg", "wa1.jpg", "wa02.jpg", "wa2.jpg", "wapa.jpg", "wapage.jpg", "wa11.jpg")

foreach ($name in $candidates) {
    $url = "$baseUrl$name"
    try {
        $req = Invoke-WebRequest -Uri $url -Method Head -ErrorAction Stop
        Write-Host "FOUND: $name"
    } catch {
        Write-Host "MISSING: $name"
    }
    Start-Sleep -Milliseconds 500
}
