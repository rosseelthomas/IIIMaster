use Win32::OLE qw(EVENTS);
$ComputerName=".";
my $Sink = Win32::OLE->new ('WbemScripting.SWbemSink');
Win32::OLE->WithEvents($Sink,\&EventCallBack);
$|=1;

my $NameSpace1 = "root/cimv2";
my $WbemServices1 = Win32::OLE->GetObject("winmgmts://$ComputerName/$NameSpace1");
my $Query1 = "SELECT * FROM __InstanceOperationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process'";
$WbemServices1->ExecNotificationQueryAsync($Sink, $Query1);

my $NameSpace2 = "root/msapps12";
my $WbemServices2 = Win32::OLE->GetObject("winmgmts://$ComputerName/$NameSpace2");
my $Query2 = "SELECT * FROM __InstanceCreationEvent WITHIN 5
     WHERE TargetInstance ISA 'Win32_ExcelWorkBook'
        or TargetInstance ISA 'Win32_Word12Document'
        or TargetInstance ISA 'Win32_PowerPointPresentation'
        or TargetInstance ISA 'Win32_AccessDataBase'";
$WbemServices2->ExecNotificationQueryAsync($Sink, $Query2);


use Win32::Console;
$console = Win32::Console->new(STD_INPUT_HANDLE);
until($console->GetEvents() && ($console->Input())[1]){
	Win32::OLE->SpinMessageLoop();
	Win32::Sleep(500);
}

$Sink->Cancel();
Win32::OLE->WithEvents($Sink);

sub EventCallBack {
my ($src, $eventname, $event, $context) = @_;
print "Eventname : $eventname\n";
print "event : ",$event->{TargetInstance}->{Name},"\n";
}