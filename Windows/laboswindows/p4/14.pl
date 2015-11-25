use Win32::OLE qw(in with);
use Win32::OLE::Const;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");

$obj = $service->Get('Win32_Service.Name="SNMP"');

for $p (in $obj->Properties_ , $obj->{SystemProperties_} ){

	print $p->{Name},"\t => ",ref($p->{Value}) ? join (" ",@{$p->{Value}}) : $p->{Value} ,"\n";

}

print "========\nen nu voor de klasse\n";

$obj = $service->Get('Win32_Service');

for $p (in $obj->Properties_ , $obj->{SystemProperties_} ){

	print $p->{Name},"\t => ",ref($p->{Value}) ? join (" ",@{$p->{Value}}) : $p->{Value} ,"\n";

}