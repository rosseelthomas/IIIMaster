use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';

$obj = $service->Get("Win32_Environment.Name=\"THOMAS___\",UserName=\"Administrator\"",wbemFlagUseAmendedQualifiers);
$obj->Delete_();