use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
 $name = $ARGV[0] || "test.xls";
 $fso = Win32::OLE->new("Scripting.FileSystemObject");
 $excel = Win32::OLE->new("Excel.Application","quit");
$wb = $excel->{Workbooks}->open($fso->GetAbsolutePathName("$name"));

$nsheet = $wb->Sheets->Item(1);

	$range=$nsheet->Range("A1:D10");
	print "inhoud range: \n";
	print join(" \t",@{$_}),"\n" foreach @{$range->{Value}};

	print"\n--\n";
	$range=$nsheet->Cells(4,1);
	print "inhoud: ",$range->{Value},"\n";
	print"\n--\n";
	$range=$nsheet->Range($nsheet->Cells(1,1),$nsheet->Cells(4,3));
	print "inhoud range: \n";
	print join(" \t",@{$_}),"\n" foreach @{$range->{Value}};
	print"\n==========\n";




