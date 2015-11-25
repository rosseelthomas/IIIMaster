use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';



$obj = $service->Get("__EventFilter",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "tmrfilter";
$new->{QueryLanguage} = "WQL";
#$new->{Query} = "select * from __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process' and TargetInstance.Name=\"notepad.exe\"";

$new->{Query} = "select * from Win32_ProcessStartTrace WHERE ProcessName=\"notepad.exe\"";

$filter = $new->Put_(wbemFlagUseAmendedQualifiers);


$obj = $service->Get("SMTPEventConsumer",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "smtpcons";
$new->{FromLine}="thomas\@ugent.be";
$new->{ToLine} = "thomas.rosseel\@ugent.be,rosseel.thomas\@gmail.com";
$new->{Subject} = "notepad geopend";
$new->{Message}="notepad geopend op %__SERVER% en %__CLASS%";
$new->{SMTPServer} = "smtp.telenet.be";
$consumer = $new->Put_(wbemFlagUseAmendedQualifiers);

$obj = $service->Get("__FilterToConsumerBinding",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Consumer} = $consumer->{Path};
$new->{Filter} = $filter->{Path};
$new->Put_(wbemFlagUseAmendedQualifiers);


$obj = $service->Get("CommandLineEventConsumer",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "cmdcons";
$new->{CommandLineTemplate} = "taskkill /f /pid %ProcessID%";

$consumer1 = $new->Put_(wbemFlagUseAmendedQualifiers);

$obj = $service->Get("__FilterToConsumerBinding",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Consumer} = $consumer1->{Path};
$new->{Filter} = $filter->{Path};
$new->Put_(wbemFlagUseAmendedQualifiers);