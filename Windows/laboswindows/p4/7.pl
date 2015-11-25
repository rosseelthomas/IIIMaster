
use Win32::OLE qw(in with);
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$services = $locator->ConnectServer(".","root/cimv2");

$o = $services->ExecQuery("select * from Win32_NetworkAdapter");
$b = $services->InstancesOf("Win32_NetworkAdapter");

print "eerst via WQL query: \n";
print "count: ",$o->{Count},"\n";
print $_->{DeviceID},"\n" for in $o;
print "======================\n";

print "nu via InstancesOf: \n";
print "count: ",$b->{Count},"\n";
print $_->{DeviceID},"\n" for in $b;
print "======================\n";

