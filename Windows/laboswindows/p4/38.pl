use Win32::OLE qw(in with);
$Win32::OLE::Warn=0;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$classname = "Win32_Volume";
$class = $service->Get($classname,wbemFlagUseAmendedQualifiers);
for $method (in $class->{Methods_}){

	if($method->{Qualifiers_}->{Values} || $method->{Qualifiers_}->{ValueMap}){

	print "Name : ",$method->{Name},"\n";
	if($method->{Qualifiers_}->{ValueMap}){
		@hash{@{$method->{Qualifiers_}->{ValueMap}->{Value}}} = @{$method->{Qualifiers_}->{Values}->{Value}};
		while(($k,$v) = each %hash){
			print "$k : $v\n";
		}
	}else{
		@vals = @{$method->{Qualifiers_}->{Values}->{Value}};
		for $i(0..@vals-1){
			print "$i : $vals[$i]\n";
		}

	}
	print "*********\n";

	}

}