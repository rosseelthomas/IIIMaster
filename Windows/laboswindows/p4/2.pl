use Win32::OLE;
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$services = $locator->ConnectServer(".","root/cimv2");
print Win32::OLE->QueryObjectType($services);
