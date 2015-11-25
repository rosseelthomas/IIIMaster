@ARGV = ("Win32_OperatingSystem","Win32_NetworkAdapter");
use Win32::OLE;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");


while($classname = shift){

$obj = $service->Get($classname);
$path = $obj->{Path_};
	while(($k,$v) =each  %{$path}){
		print "$k : $v","\n";
	}

print "========\n";

	
}