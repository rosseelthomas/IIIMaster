use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
 $name = $ARGV[0] || "test.xls";
 $fso = Win32::OLE->new("Scripting.FileSystemObject");
 $excel = Win32::OLE->new("Excel.Application","quit");

 if(!$fso->FileExists($name)){

 	$wb = $excel->{Workbooks}->Add;
 	$wb->SaveAs($fso->GetAbsolutePathName(".")."/$name");

 	
 }else{

 	$wb = $excel->{Workbooks}->open($fso->GetAbsolutePathName("$name"));
 }



print $wb->{Sheets}->{Count};
print "\n";