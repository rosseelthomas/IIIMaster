use Win32::OLE;
$Win32::OLE::Warn = 3;
use Win32::OLE::Const ".*Excel";
$fso = Win32::OLE->new("Scripting.FileSystemObject");
$excel = Win32::OLE->new("Excel.Application","quit");
$wb = $excel->{Workbooks}->Add();

for $i (1..9){
	$c = $i + 1;
	$j = 0;
	while ($c<=100){

		$mat->[$j][$i-1] = $c;

		$c += $i+1;
		++$j;
	}

}

$sheet = $wb->{Sheets}->Item(1);
 $sheet->Range("A1:I1")->{font}->{bold} = 1;
 $sheet->Range("A1:I1")->Borders(xlEdgeBottom)->{LineStyle} = xlContinuous;
 $sheet->Range("A1:I50")->Borders(xlInsideVertical)->{LineStyle} = xlContinuous;

$wb->{Sheets}->Item(1)->Range("A1:I50")->{Value} = $mat;



$wb->SaveAs($fso->GetAbsolutePathName(".")."/voud.xlsx");

