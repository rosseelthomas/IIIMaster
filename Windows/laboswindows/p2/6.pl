use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
$name = "test.xls";
$fso = Win32::OLE->new("Scripting.FileSystemObject");
$excel = Win32::OLE->new("Excel.Application","quit");
$wb = $excel->{Workbooks}->open($fso->GetAbsolutePathName("$name"));

$sheet = $wb->Sheets->Item(1);
$range = $sheet->Range("A1:B2");
$val = $range->{Value};
#${${$val}[0]}[0] = 100;
$val->[0][0]="100";
$range->{Value} = $val;
 $wb->Save();

#$sheet->Cells(1,1)->{Value} = 200;

 $r = $sheet->Cells(1,1);
 print $r->{Value};
