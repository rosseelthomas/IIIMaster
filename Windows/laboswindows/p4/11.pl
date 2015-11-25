use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");

$c = $service->Get("Win32_IRQResource.IRQNumber=-2");
print $c->Associators_("","Win32_NetworkAdapter")->{Count},"\n";
print $_->{Description},"\n" for in $c->Associators_("","Win32_NetworkAdapter");