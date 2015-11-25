use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$servicename = "SNMP";
$class="Win32_Service";
$srvs = $service->ExecQuery("select * from $class where Name='$servicename'","WQL",wbemFlagUseAmendedQualifiers);
$c = $service->Get($class, wbemFlagUseAmendedQualifiers);

$srv = (in $srvs)[0];
if($srv->{State} eq "Stopped"){
	$method = $c->{Methods_}->Item("StartService");
	my %hash;

	@hash{@{$method->{Qualifiers_}->{ValueMap}->{Value}}} = @{$method->Qualifiers_(Values)->{Value}};
	$ret = $srv->ExecMethod_("StartService");
	print "starting : ",$hash{$ret->{ReturnValue}},"\n";


}else{
	$method = $c->{Methods_}->Item("StopService");
	my %hash;

	@hash{@{$method->{Qualifiers_}->{ValueMap}->{Value}}} = @{$method->Qualifiers_(Values)->{Value}};
	$ret = $srv->ExecMethod_("StopService");
	print "stopping : ",$hash{$ret->{ReturnValue}},"\n";


}