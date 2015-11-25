use Win32::OLE qw(in with);
use Win32::OLE::Const;
use Win32::OLE::Variant;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");
$datetime = Win32::OLE->new("WbemScripting.SWbemDateTime");

$obj = $service->Get('Win32_OperatingSystem=@');
%h = %{Win32::OLE::Const->Load($locator)};
while (($k,$v) = each %h){
	
	$types{$v} = $k if $k =~ /cimtype/i ;

}
for $p (in $obj->Properties_ , $obj->{SystemProperties_} ){

	print $p->{Name},"\t => ";
	if (ref($p->{Value})) {
		 print join (" ",@{$p->{Value}});

		}elsif($p->{Value}) {

			if($types{$p->{cimtype}} =~ /(date|time)/i){
				$datetime->{Value} = $p->{Value};
				print $datetime->GetVarDate();

				}else{
					print $p->{Value};
				}

			} 


	print "\n";

}
