use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft WMI Scripting';
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("WbemScripting.SwbemLocator");
$service = $locator->connectserver(".","root/cimv2");
$|=1;
@classes = ("Win32_LocalTime", "Win32_DiskDrive" ,"Win32_Product");

for $cn(@classes){


$class = $service->Get($cn);
$instance  = (in $class->Instances_(wbemFlagUseAmendedQualifiers))[0];


print "=============\n","voor $cn:\n","=============\n";
for $q(in $class->{Qualifiers_}){
	print "$q->{Name} : $q->{Value}\n";
}

print "=============\n","voor instantie van $cn:\n","=============\n";
for $q(in $instance->{Qualifiers_}){
	print "$q->{Name} : $q->{Value}\n";
}
print "=============\n";
}