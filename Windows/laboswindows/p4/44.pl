use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$service=Win32::OLE->GetObject("winmgmts:{(Restore)}!//./root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$cla = $service->Get("Win32_Process",wbemFlagUseAmendedQualifiers);

$method = $cla->{Methods_}->Item("Create");