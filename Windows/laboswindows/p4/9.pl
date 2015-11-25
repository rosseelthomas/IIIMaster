use Win32::OLE qw(in with);
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$services = $locator->ConnectServer(".","root/cimv2");

$obj = $services->AssociatorsOf("Win32_Directory",undef,undef,undef,undef,0,1);

print $obj->{Count} , " geassocieerde klassen:\n";
print $_->SystemProperties_->{"__Path"}->{Value},"\n" for in $obj;