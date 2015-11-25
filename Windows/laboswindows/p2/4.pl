use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
 $name = $ARGV[0] || "test.xls";
 $fso = Win32::OLE->new("Scripting.FileSystemObject");
 $excel = Win32::OLE->new("Excel.Application","quit");
$wb = $excel->{Workbooks}->open($fso->GetAbsolutePathName("$name"));


for $sheet (in $wb->Sheets){

	print $sheet->Name;
	print "\n";
	$ur = $sheet->UsedRange;
	if(ref $ur->{Value}){
		@rows = @{$ur->{Value}};


		
			for $row (@rows){
				@cols = @{$row};
				print join "\t",@cols;
				print "\n";

			}

		
	}else{

		if($ur->{Value}){
			print "val: ".$ur->{Value};
		}else{
			print "leeg werkblad";
		}

	}

	print "\n\n";
}