use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$obj = $service->Get("Win32_Environment",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "THOMAS___";
$new->{UserName} = "Administrator";
$new->{VariableValue} = "test";
$new->{Description} = "Awesome environment";
$path = $new->Put_(wbemFlagUseAmendedQualifiers);

print $path->{Path},"\n";

sub maakhash {
	$obj = $_[0];

	my %hash;
	@hash{@{$obj->{Qualifiers_}->{ValueMap}->{Value}}} = @{$obj->{Qualifiers_}->{Values}->{Value}};
	return %hash;

}