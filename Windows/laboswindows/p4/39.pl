use Win32::OLE qw(in with);
$Win32::OLE::Warn=0;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$classname = "Win32_Process";
$class = $service->Get($classname,wbemFlagUseAmendedQualifiers);
for $method (in $class->{Methods_}){



	print "Name : ",$method->{Name}," (";
		if($method->InParameters){

		for $p(sort {$a->{Qualifiers_}->Item("ID")->{Value} <=> $b->{Qualifiers_}->Item("ID")->{Value}}in $method->InParameters->{Properties_}){
			$name = $p->{Name};
			if($p->{Qualifiers_}->Item("Optional") && $p->{Qualifiers_}->Item("Optional")->{Value}){
				print " [$name] ";
			}else{
				print " $name ";
			}

		}	
		}

		print " )\n";
if($method->OutParameters && $method->OutParameters->{Properties_}->{Count}>1){

		for $p(in $method->OutParameters->{Properties_}){
			$name = $p->{Name};
			
				print "$name ";
			

		}
		print "\n";	
}

print "static\n" if ($method->{Qualifiers_}->Item("Static") && $method->{Qualifiers_}->Item("Static")->{Value});
		

	print "*********\n";



}