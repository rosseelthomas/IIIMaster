use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");



geefstatus("Begin ");
my $Excel =  Win32::OLE->new('Excel.Application', 'Quit');
geefstatus("Nieuwe Excel Applicatie gestart");
my $Excel = Win32::OLE->GetActiveObject('Excel.Application');
geefstatus("Draaiende Excel-applicatie gebruiken");
my $Book = $Excel->Workbooks->Add();
geefstatus("Werkbook toegevoegd");
$Book->Save();
geefstatus("Werkboek opgeslaan");



sub geefstatus {
	print "====================\n";
	print $_[0];
	print "\n====================\n";

	Win32::OLE->EnumAllObjects(
		sub {
			my $obj = shift;
			
			if (Win32::OLE->QueryObjectType($obj) =~ /Excel/ ){
				print Win32::OLE->QueryObjectType($obj);
			for my $p (in $obj->{Properties}){
				print $p->{Name}," : ",$p->{Value},"\n";
			}
			print "\n\n";
			}
			});

}