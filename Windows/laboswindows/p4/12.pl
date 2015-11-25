use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");

$obj = $service->InstancesOf("Win32_Environment");

for (sort {$a->{Name} cmp $b->{Name} }in $obj) {
	print $_->{Name},"\t",$_->{VariableValue},"\t",$_->{UserName},"\n";

}