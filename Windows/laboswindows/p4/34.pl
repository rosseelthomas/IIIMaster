use Win32::OLE qw(in with);
$Win32::OLE::Warn=0;
use Win32::OLE::Const 'Microsoft WMI Scripting';
$locator=Win32::OLE->new("Wbemscripting.swbemlocator");
$service = $locator->ConnectServer(".","root/cimv2");
$| = 1;

$class="Win32_NetworkAdapter";
$co = $service->Get($class,wbemFlagUseAmendedQualifiers);
@av{@{$co->{Properties_}->Item("Availability")->{Qualifiers_}->Item("ValueMap")->{Value}}} = @{$co->{Properties_}->Item("Availability")->{Qualifiers_}->Item("Values")->{Value}};
@status{@{$co->{Properties_}->Item("NetConnectionStatus")->{Qualifiers_}->Item("ValueMap")->{Value}}} = @{$co->{Properties_}->Item("NetConnectionStatus")->{Qualifiers_}->Item("Values")->{Value}};


for $inst (in $co->Instances_()){

	print "Name : ",$inst->{Name},"\n";
	print "Availability : ",$av{$inst->{Availability}},"\n";
	print "MAC : ",$inst->{MACAddress},"\n";
	print "Status : ",$status{$inst->{NetConnectionStatus}},"\n";
	print "======================\n";

}
