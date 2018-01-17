#$encoding = [Console]::OutputEncoding  #Cyrillic (Windows 1251)
#$ScriptPath = (Get-Item -Path ".\" -Verbose).FullName;
#cd "\\192.168.2.10\control_system";
#cd "00 Переписка";
#ls
#cd $ScriptPath;

$files = Get-ChildItem -Path "\\192.168.2.10\control_system\00 Переписка\" -Recurse -ErrorAction SilentlyContinue -Force; # | sort
$dates = @{}; $i = 0; $pgsWrd = 0;
foreach ($file in $files){
	$fullString = $file.fullName;
	$nPages = 0;

	if (($fullString.SubString($fullString.length-5,1) -eq ".") -or ($fullString.SubString($fullString.length-4,1) -eq ".")){ #//files

		if (($fullString.SubString($fullString.length-3,3) -eq "doc") -or ($fullString.SubString($fullString.length-4,4) -eq "docx") -or ($fullString.SubString($fullString.length-3,3) -eq "pdf")){ #//word & pdf

			$checkPages = $true;
			if (($fullString.SubString($fullString.length-3,3) -eq "doc") -or ($fullString.SubString($fullString.length-4,4) -eq "docx")){ #//check N of Pages (BLOCK)
				"Counting pages: " + $fullString
				$objWord = New-Object -ComObject word.application
				$objWord.visible = $false #$true
				$objDoc = $objWord.documents.open($fullString)
				$nPages = $objDoc.ComputeStatistics(2) 
				$objDoc.Close();
				$objWord.Quit()
				if ($nPages -ge 16){
					$checkPages = $false;
				}
				$nPages
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
							$s = $dateString.Captures[0].value;
							$d = "20" + $s.SubString(6,2) + "-" + $s.SubString(3,2) + "-" + $s.SubString(0,2);
							$dates[$fullString] = $d;		
						}
						else{ #//Дата создания
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

    $i += 1;
}

$res = $dates.GetEnumerator() | Sort Value
$res

$res.length
"Includes N = Word Pages = "+$pgsWrd

$counter = 0;
foreach ($r in $res){ #//Print All Sorted
	#start-process -FilePath $r.Name -Verb Print
	$r.Name

	$counter++;
	$counter
}
"Done"







###//Notes
#$testfile = "\\192.168.2.10\control_system\00 Переписка\Шаблон письма новый.docx"
#start-process -FilePath $testfile.fullName -Verb Print

#$dates = @()
#$dates += ,$dateString.Captures[0].value

# $objDoc.ComputeStatistics(2) == число страниц