use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");
$obj = $service->ExecQuery("select * from Win32_NTLogEvent where EventCode=6005 or EventCode=6006");

for $o(in $obj){
	if($o->{Message} =~ /started/){


	}elseif{
		
		
	}

}