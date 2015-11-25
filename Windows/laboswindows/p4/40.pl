use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$classname = "Win32_Process";
$notepads = $service->ExecQuery("select * from $classname where Name='notepad.exe'","WQL",wbemFlagUseAmendedQualifiers);
for $n(in $notepads){

	#directe techniek
	#$retmsg = $n->Terminate(2);

	#formele techniek
	$term = $n->{Methods_}->Item("Terminate");
	$in = $term->{InParameters};
	$in->{Reason} = 2;
	$ret = $n->ExecMethod_("Terminate", $in);
	$retmsg = $ret->{ReturnValue};
	print "msg : $retmsg\n";
}