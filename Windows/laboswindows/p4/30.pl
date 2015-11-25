use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft WMI Scripting';
$locator=Win32::OLE->new("Wbemscripting.swbemlocator");
$service = $locator->ConnectServer(".","root/cimv2");

$hr = Win32::OLE::Const->Load("Microsoft WMI Scripting");

while (($k,$v) = each %{$hr}){

	$types{$v} = $k;
} 

$class = "Win32_Directory";
$co = $service->Get($class,wbemFlagUseAmendedQualifiers);
for $p(in $co->{Properties_}){
	print "=============\n";
	print "name: ",$p->{Name},"\n";
	print "CIM: ",$types{$p->{cimtype}},"\n";
	print "CIM volgens qualifiers: ",$p->{Qualifiers_}->Item("cimtype")->{Value},"\n";

}