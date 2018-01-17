#Cyrillic (Windows 1251)
$files = Get-ChildItem "\\192.168.2.10\control_system\00 Переписка\03 Протоколы совещаний" -Filter *.doc? | Sort-Object Name;
foreach ($file in $files){
	#$file.fullName; ##
}

if ([string]::IsNullOrEmpty($args[0]) -eq $true){
	$file = $files[-1];
	$fileName = $file.fullName;
	$file
}
else{
	$fileName = $args[0];
}

$wd = New-Object -com word.application
$wd.visible = 1; #
$doc = $wd.Documents.Open($fileName); $i = 0;
$todo = @();
$date = @();
$piece = "";
foreach ($paragraph in $doc.Range().paragraphs){
	$i++; $piece += $paragraph.range.text; ############################################################# split and done
	$s = $paragraph.range.text | Select-String -Pattern "Ответственный" | Select-String -Pattern "Газпром"
	if ([string]::IsNullOrEmpty($s) -eq $true){	$s = $paragraph.range.text | Select-String -Pattern "Ответственный" | Select-String -Pattern "Газин" }
	if ([string]::IsNullOrEmpty($s) -eq $true){	$s = $paragraph.range.text | Select-String -Pattern "Ответственный" | Select-String -Pattern "Шарохин" }
	if ([string]::IsNullOrEmpty($s) -eq $false){
		$todoItem = $doc.Paragraphs.item($i-1).Range.text;
		#$todoItem

		$todo += $todoItem; #$doc.Paragraphs.item($i-1).Range.text;
		$itemDate = $doc.Paragraphs.item($i+1).Range.text | Select-String -Pattern "Срок исполнения";
		if ([string]::IsNullOrEmpty($itemDate) -eq $false){
			$itemDate =$itemDate -Replace "Срок исполнения: ", "";
			$itemDate =$itemDate -Replace "Срок исполнения:", "";
			$itemDate =$itemDate -Replace "Срок исполнения", "";
			while ($itemDate.Substring($itemDate.Length-2,1) -eq " "){ $itemDate = $itemDate.Substring(0,$itemDate.Length-2); }
			if ($itemDate.Substring($itemDate.Length-2,1) -eq "."){ $itemDate = $itemDate.Substring(0,$itemDate.Length-2); }
			$date += $itemDate;
		}
	}
}
$doc.Close(); $wd.quit();

$const1 = 1; $const2 = 2;
$const3 = 3; $const4 = 4;
$const5 = 5; $const6 = 6;
$const7 = 7; $const8 = 8; #const cells
if ([string]::IsNullOrEmpty($todo[0]) -eq $false){
	$xl = New-Object -ComObject excel.application
	$xl.visible = 1; #
	$docxl = $xl.Workbooks.Open("C:\Users\lazareva_sa\Downloads\_POWERSHELL\List.xlsx");
	$WorkSheet = $docxl.Sheets.Item(1) 
	
	$n = 0;
	$objRange = $WorkSheet.UsedRange;
	$lastRow = $objRange.SpecialCells(11).row;
	
	$textNum = $WorkSheet.Cells.Item($lastRow+$n,1).text
	while (([string]::IsNullOrEmpty($WorkSheet.Cells.Item($lastRow+$n,2).text) -eq $true) -and ([string]::IsNullOrEmpty($WorkSheet.Cells.Item($lastRow+$n,1).text) -eq $true) -and ($lastRow -gt 1)){
		$lastRow = $lastRow - 1;
		$textNum = $WorkSheet.Cells.Item($lastRow+$n,1).text;
	}
	$intNum = [int]$textNum; $next = $intNum+1
	
	$t = 0;
	foreach ($td in $todo){
		$textNum = $WorkSheet.Cells.Item($lastRow+$n,1).text;
		$intNum = [int]$textNum; $next = $intNum+1

		$WorkSheet.Cells.Item($lastRow+1+$n,$const1) = [string]($next);
		$itemDate = $date[$t];
		if ([string]::IsNullOrEmpty($itemDate) -eq $false){ $WorkSheet.Cells.Item($lastRow+1+$n,$const3) = [string]($itemDate); }
		$WorkSheet.Cells.Item($lastRow+1+$n,$const6) = [string]($td);
		$fname = $fileName.Split('\')[-1]
		$fname = $fname -Replace "\.docx$", ""
		$fname = $fname -Replace "\.doc$", ""
		$fname = $fname -Replace "Протокол_", ""
		$fname = $fname -Replace "Протокол ", ""
		$WorkSheet.Cells.Item($lastRow+1+$n,$const7) = $fname;
		$WorkSheet.Cells.Item($lastRow+1+$n,$const8) = $fileName;
		$t++; $lastRow = $lastRow + 1;
	}

	$docxl.Save();
	$docxl.Close();
}
"Done"

# $date.GetType()
# $doc.Range.GetType() | get-member

#$abz = ""; $k = 0;
#foreach ($par in $doc.Range().paragraphs){
#	if ($k -lt 5){
#		$abz += $par.range.text;
#	}
#	$k++;
#}
#$abz
