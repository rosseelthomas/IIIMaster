use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft WMI Scripting';
$Win32::OLE::Warn=0;
$locator = Win32::OLE->new("WbemScripting.SwbemLocator");
$service = $locator->connectserver(".","root/cimv2");
$|=1;


for $class(in $service->SubclassesOf()){

if(istrue("SupportsCreate")) {
	print $class->{SystemProperties_}->{__CLASS}->{Value}," supports creation by ",$class->{Qualifiers_}->{CreateBy}->{Value},"\n";
}

if(istrue("SupportsDelete")) {
	print $class->{SystemProperties_}->{__CLASS}->{Value}," supports deletion by ",$class->{Qualifiers_}->{DeleteBy}->{Value},"\n";
}

}



sub istrue{
	return ($class->{Qualifiers_}->{$_[0]} && $class->{Qualifiers_}->{$_[0]}->{Value} == 1);
}