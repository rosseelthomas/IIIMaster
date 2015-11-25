use Win32::OLE qw(in with);
$Win32::OLE::Warn=0;
use Win32::OLE::Const 'Microsoft WMI Scripting';
$locator=Win32::OLE->new("Wbemscripting.swbemlocator");
$service = $locator->ConnectServer(".","root/cimv2");
$| = 1;

$class="Win32_NetworkAdapter";
$co = $service->Get($class,wbemFlagUseAmendedQualifiers);
for $p (in $co->{Properties_}){

	if($p->{Qualifiers_}->Item("ValueMap")){
		my %hash;
		@hash{@{$p->{Qualifiers_}->Item("ValueMap")->{Value}}} = @{$p->{Qualifiers_}->Item("Values")->{Value}};
		print "Name: ",$p->{Name},"\n";
		print "Description: ", $p->{Qualifiers_}->Item("Description")->{Value},"\n";

		while (($k,$v) = each %hash){
			print "$k : $v\n";
		}
		print "=====================\n";
	}

}