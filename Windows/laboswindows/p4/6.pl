
use Win32::OLE qw(in with);
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$services = $locator->ConnectServer(".","root/cimv2");
$class = $services->Get('Win32_OperatingSystem');
print $_->{Version},"\n" foreach in $class->Instances_();
print "----\n";
print "$_->{Version}","\n" foreach in $services->ExecQuery("select * from Win32_OperatingSystem");
print "----\n";
print $_->{Version},"\n" foreach in $services->InstancesOf("Win32_OperatingSystem");

