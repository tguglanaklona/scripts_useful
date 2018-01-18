#$encoding = [Console]::OutputEncoding  #Cyrillic (Windows 1251)
#$ScriptPath = (Get-Item -Path ".\" -Verbose).FullName;
#cd "\\192.168.2.10\control_system";
#cd "00 œÂÂÔËÒÍ‡";
#ls
#cd $ScriptPath;

$files = Get-ChildItem -Path "\\192.168.2.10\control_system\00 œÂÂÔËÒÍ‡\" -Recurse -ErrorAction SilentlyContinue -Force; # | sort
$dates = @{}; $i = 0; $pgsWrd = 0;
foreach ($file in $files){
	$fullString = $file.fullName
	$nPages = 0;
	#if (($fullString -match "Õœ÷¿œ") -eq $true){ ##todo: not temprorary œÂ˜‡Ú‡ÂÏ ÒÌ‡˜‡Î‡ ËÁ Ô‡ÔÍË Õœ÷¿œ

		if (($fullString.SubString($fullString.length-5,1) -eq ".") -or ($fullString.SubString($fullString.length-4,1) -eq ".")){ #//files

			#if (($fullString.SubString($fullString.length-3,3) -eq "doc") -or ($fullString.SubString($fullString.length-4,4) -eq "docx") -or ($fullString.SubString($fullString.length-3,3) -eq "pdf")){ #//word & pdf
			if ($fullString.SubString($fullString.length-3,3) -eq "pdf"){ #// pdf

				$checkPages = $true;
				#if (($fullString.SubString($fullString.length-3,3) -eq "doc") -or ($fullString.SubString($fullString.length-4,4) -eq "docx")){ #//check N of Pages (BLOCK)
				#	"Counting pages: " + $i + " " + $fullString
				#	"Counting pages: " + $i + " " + $fullString >> "log.txt"
				#	$objWord = New-Object -ComObject word.application
				#	$objWord.visible = $false #$false #$true
				#	$objWord.DisplayAlerts = "wdAlertsNone";
				#	$objDoc = $objWord.documents.OpenNoRepairDialog($fullString,$false,$false,$false,"","",$true,"","","wdOpenFormatAuto",$null,$true,$false,$null,$true)
				#	#$objDoc = $objWord.documents.Open($fullString,$false,$true);
				#	$nPages = $objDoc.ComputeStatistics(2) 
				#	$objDoc.Close();
				#	$objWord.Quit()
				#	if ($nPages -ge 16){
				#		$checkPages = $false;
				#	}
				#	$nPages
				#	$nPages >> "log.txt"
				#}

				if ($file.Length -gt 1500000){#// check pdf size
					$checkPages = $false;
				}

				if ($checkPages){
			
					$pgsWrd += $nPages;
					$a = [regex]"2017?8?\-..\-..";
					$dateString = $a.Match($fullString);
					if ($dateString.Captures[0].value){
						$d = $dateString.Captures[0].value;
						$dates[$fullString] = $d;
					}
					else{                
						$a = [regex]"..\...\.2017?8?";
						$dateString = $a.Match($fullString)
						if ($dateString.Captures[0].value){
							if ($dateString.Captures[0].value.length -eq 10){ #//2017 or 2018
								$s = $dateString.Captures[0].value
								$d = $s.SubString(6,4) + "-" + $s.SubString(3,2) + "-" + $s.SubString(0,2);
								$dates[$fullString] = $d;		
							}
						}
						else{
							$a = [regex]"..\...\.17?8?";
							$dateString = $a.Match($fullString)
							if ($dateString.Captures[0].value){
								if ($dateString.Captures[0].value.length -eq 8){ #//17 or 18
									$s = $dateString.Captures[0].value;
									$d = "20" + $s.SubString(6,2) + "-" + $s.SubString(3,2) + "-" + $s.SubString(0,2);
									$dates[$fullString] = $d;		
								}
							}
							else{ #//Creation Date
								$tempm = [string]$file.CreationTime.Month;
								if ($file.CreationTime.Month -lt 10) {$tempm = "0"+[string]$file.CreationTime.Month;};
								$tempd = [string]$file.CreationTime.Day;
								if ($file.CreationTime.Day -lt 10) {$tempd = "0"+[string]$file.CreationTime.Day;};
								$d = [string]$file.CreationTime.Year + "-" + $tempm + "-" + $tempd;
								$dates[$fullString] = $d;
							}
						}
					}

				}

			}
			else{
				#"this is not doc pdf: " + $fullString
			}

		}
		else{
			#"this is folder: " + $fullString
		}
	#}
	#else{
	#	"HERE WE ARE" #This is a Trash file
	#}
	$i += 1;
}

$res = $dates.GetEnumerator() | Sort Value
#$res

$res.length
"Includes N = Word Pages = "+$pgsWrd
"Includes N = Word Pages = "+$pgsWrd >> "log.txt"


"All Sorted:" >> "log.txt"
$counter = 0;
foreach ($r in $res){ #//Print All Sorted
	start-process -FilePath $r.Name -Verb Print
	$r.Name
	$r.Name >> "log.txt"

	$counter++;
	$counter
}
"Done"
"Done">>"log.txt"







###//Notes
#$testfile = "\\192.168.2.10\control_system\00 –ü–µ—Ä–µ–ø–∏—Å–∫–∞\–®–∞–±–ª–æ–Ω –ø–∏—Å—å–º–∞ –Ω–æ–≤—ã–π.docx"
#start-process -FilePath $testfile.fullName -Verb Print

#$dates = @()
#$dates += ,$dateString.Captures[0].value

# $objDoc.ComputeStatistics(2) == —á–∏—Å–ª–æ —Å—Ç—Ä–∞–Ω–∏—Ü
#https://msdn.microsoft.com/en-us/VBA/Excel-VBA/articles/workbooks-open-method-excel
#$objWord.DisplayAlerts = "wdAlertsNone";
#$objDoc = $objWord.documents.OpenNoRepairDialog($fullString)