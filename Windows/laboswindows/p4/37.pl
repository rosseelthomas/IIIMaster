use Win32::OLE qw(in with);
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$classname = "Win32_Process";
$class = $service->Get($classname,wbemFlagUseAmendedQualifiers);
for $method (in $class->{Methods_}){

	print "Name : ",$method->{Name},"\n";
	for $q(in $method->{Qualifiers_}){
		print "\t",$q->{Name}," : ",ref($q->{Value}) ? join(" ",@{$q->{Value}}) : $q->{Value},"\n";
	}

	print "*********\n";
}