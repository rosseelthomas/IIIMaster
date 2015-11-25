use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");

($c)  = in $service->ExecQuery("select * from Win32_Directory where Name='C:'");
print "aantal geassoc instanties: ",$c->Associators_()->{Count},"\n";
print "#klassen: ",$c->Associators_(undef,undef,undef,undef,1)->{Count},"\n";