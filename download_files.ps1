$start_time = Get-Date

For ($i=1; $i -lt 100; $i++){
    $url = "https://google.com/$i.jpg"    
    $output = "google_$i.jpg"
    
    Invoke-WebRequest -Uri $url -OutFile $output
}
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
