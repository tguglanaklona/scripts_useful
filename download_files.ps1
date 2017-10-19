$start_time = Get-Date

For ($i=1; $i -lt 100; $i++){

    if ($i -lt 10){
        $url = "https://deti-online.com/images/raskraski/raskraski-dlja-malchikov--tachki--0$i.jpg"    
        $output = "tachki\tachki_0$i.jpg"
    }
    else{
        $url = "https://deti-online.com/images/raskraski/raskraski-dlja-malchikov--tachki--$i.jpg"
        $output = "tachki\tachki_$i.jpg"
    }

    Invoke-WebRequest -Uri $url -OutFile $output

}
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"