$| = 1;
@ClassNames=qw(Win32_PerfFormattedData_PerfOS_System Win32_PerfFormattedData_PerfOS_Processor Win32_PerfFormattedData_PerfDisk_LogicalDisk Win32_PerfFormattedData_PerfOS_Memory);
use Win32::OLE qw(in with);
$locator=Win32::OLE->new("wbemscripting.swbemlocator");
$service = $locator->connectserver(".","root/cimv2");

$refresher = Win32::OLE->new("wbemscripting.swbemrefresher");

for $classname(@ClassNames){
	$refresher->AddEnum($service,$classname);
}

while(1){
	
	$refresher->Refresh();
	for $set(in $refresher){
		for $item(in $set->{ObjectSet}){
			print $item->{Name} || "";
			for $p(in $item->{Properties_}){
				print $p->{Name}," : ",$p->{Value},"\n";
			}
			print "\n";
		}


		print "\n\n";

	}

	sleep 10;
}