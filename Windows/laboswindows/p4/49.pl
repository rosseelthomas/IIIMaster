use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$obj = $service->Get("__IntervalTimerInstruction",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{TimerId} = "tmr";
$new->{IntervalBetweenEvents} = 10000;
$tmr = $new->Put_(wbemFlagUseAmendedQualifiers);


$obj = $service->Get("__EventFilter",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "tmrfilter";
$new->{QueryLanguage} = "WQL";
$new->{Query} = "select * from __TimerEvent";
$filter = $new->Put_(wbemFlagUseAmendedQualifiers);


$obj = $service->Get("SMTPEventConsumer",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Name} = "smtpcons";
$new->{FromLine}="thomas\@ugent.be";
$new->{ToLine} = "thomas.rosseel\@ugent.be";
$new->{Subject} = "TIMER EVENT";
$new->{Message}="Timer event opgetreden";
$new->{SMTPServer} = "smtp.telenet.be";
$consumer = $new->Put_(wbemFlagUseAmendedQualifiers);

$obj = $service->Get("__FilterToConsumerBinding",wbemFlagUseAmendedQualifiers);
$new = $obj->SpawnInstance_();
$new->{Consumer} = $consumer->{Path};
$new->{Filter} = $filter->{Path};
$new->Put_(wbemFlagUseAmendedQualifiers);