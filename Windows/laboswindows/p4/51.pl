use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';


for $o(in $service->InstancesOf("__IndicationRelated")){
	$o->Delete_();
}
die;

$obj = $service->Get("__EventFilter",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "tmrfilter";
$new->{QueryLanguage} = "WQL";
$new->{Query} = "select * from __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_LogicalDisk' and TargetInstance.DeviceID<>\"C:\" and  TargetInstance.DeviceID<>\"D:\"";



$filter = $new->Put_(wbemFlagUseAmendedQualifiers);


$obj = $service->Get("ActiveScriptEventConsumer",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "perlcons";
$new->{ScriptingEngine}="PerlScript";
$new->{ScriptText} = q[open FILE,">>C:\\\\usb.txt";print FILE 'usb ingeplugd\n';];
$consumer = $new->Put_(wbemFlagUseAmendedQualifiers);

$obj = $service->Get("__FilterToConsumerBinding",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Consumer} = $consumer->{Path};
$new->{Filter} = $filter->{Path};
$new->Put_(wbemFlagUseAmendedQualifiers);
