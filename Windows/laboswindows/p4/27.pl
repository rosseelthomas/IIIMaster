use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft WMI Scripting';
$Win32::OLE::Warn=0;
$locator = Win32::OLE->new("WbemScripting.SwbemLocator");
$service = $locator->connectserver(".","root/cimv2");
$|=1;
@classes = ("Win32_LocalTime", "Win32_DiskDrive" ,"Win32_CurrentTime", "Win32_WMISetting" ,"CIM_LogicalDevice");

for $cn(@classes){


$class = $service->Get($cn);
#$instance  = (in $class->Instances_(wbemFlagUseAmendedQualifiers))[0];

if(istrue(Singleton)) {
	print "$cn is Singleton \n";
}else{
	print "$cn is geen Singleton \n";
}

}

sub istrue{
	return ($class->{Qualifiers_}->{$_[0]} && $class->{Qualifiers_}->{$_[0]}->{Value} == 1);
}