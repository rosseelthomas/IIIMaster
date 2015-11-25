use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft WMI Scripting';
$Win32::OLE::Warn=0;
$locator = Win32::OLE->new("WbemScripting.SwbemLocator");
$service = $locator->connectserver(".","root/cimv2");
$|=1;

$abstractcount=0;
$assoccount=0;
$dynamic=0;
$singleton=0;

for $class(in $service->SubclassesOf()){

if(istrue("Abstract")) {
	$abstractcount++;
}

if(istrue("Association")) {
	$assoccount++;
}

if(istrue("Dynamic")) {
	$dynamic++;
}

if(istrue("Singleton")) {
	$singleton++;
}

}


print "abstract: $abstractcount\nassoc: $assoccount\ndynamic: $dynamic\nsingleton: $singleton\n";

sub istrue{
	return ($class->{Qualifiers_}->{$_[0]} && $class->{Qualifiers_}->{$_[0]}->{Value} == 1);
}