use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft WMI Scripting';
$Win32::OLE::Warn=0;
$locator = Win32::OLE->new("WbemScripting.SwbemLocator");
$service = $locator->connectserver(".","root/cimv2");

%providers;


$classes = $service->SubclassesOf(undef, wbemFlagUseAmendedQualifiers);
for $class (in $classes){

	
	if($class->{Qualifiers_}->Item("Provider")){
		$providers{$class->{Qualifiers_}->Item(provider)->{Value}}++;
	}else{
		$provider{"ontbreekt"} ++;
	}

}

while (($k,$v) = each %providers){
	print "$k : $v\n";
}