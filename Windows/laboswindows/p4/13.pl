use Win32::OLE qw(in with);
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");

%h = %{Win32::OLE::Const->Load($locator)};
while (($k,$v) = each %h){
	
	$types{$v} = $k if $k =~ /cimtype/i ;

}


$class = "Win32_Directory";

$c = $service->Get($class);


for $p (in $c->Properties_ , $c->{SystemProperties_} ){

	print $p->{Name},"\t",$types{$p->{CIMTYPE}},"\t",$p->{isArray},"\n";
}