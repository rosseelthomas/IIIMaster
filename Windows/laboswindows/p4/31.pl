use Win32::OLE qw(in with);
$Win32::OLE::Warn=0;
use Win32::OLE::Const 'Microsoft WMI Scripting';
$locator=Win32::OLE->new("Wbemscripting.swbemlocator");
$service = $locator->ConnectServer(".","root/cimv2");
$| = 1;
$classes = $service->SubclassesOf();

for $class (in $classes) {

	@keys = map {$_->{Name}} grep {issettrue($_,"Key")} in $class->{Properties_};
	print $class->{SystemProperties_}->{__CLASS}->{Value}," ", join (" ",@keys),"\n" if @keys>1;
}


sub issettrue {

	my ($obj,$key) = @_;
	return ($obj->{Qualifiers_}->Item($key) && $obj->{Qualifiers_}->Item($key)->{Value}==1);

}