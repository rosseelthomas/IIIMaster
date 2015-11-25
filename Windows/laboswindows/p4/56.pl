use Win32::OLE qw(in with);
$locator=Win32::OLE->new("wbemscripting.swbemlocator");
$service = $locator->connectserver(".","root/cimv2");
$evsrc = $service->ExecNotificationQuery("select * from __InstanceModificationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Service' ");
$| = 1;
while(1){
	$ev = $evsrc->NextEvent(5000);
	if($ev){
		print $ev->{TargetInstance}->{Name},"\n";
	}else{
		print ".\n";
	}

}