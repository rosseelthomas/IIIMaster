use Win32::OLE;
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$services = $locator->ConnectServer(".","root/cimv2");
$n = $services->Get("Win32_NetworkAdapter");
print join "/", Win32::OLE->QueryObjectType($n),"\n";
$m = Win32::OLE->GetObject('winmgmts://WIN-2IONM1VK9F3\ROOT\CIMV2:Win32_NetworkAdapter');
print join "/", Win32::OLE->QueryObjectType($m),"\n";

$o = $services->Get('Win32_NetworkAdapter.DeviceID="9"');
print $o->{Name},"\n";
