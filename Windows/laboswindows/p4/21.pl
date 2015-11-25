use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");
$service = $locator->ConnectServer(".","root/cimv2");

$srv = $service->ExecQuery("select * from Win32_Service where state='Running'");
$dep = $service->InstancesOf("Win32_DependentService");

for $d (in $dep){
	@antecedent = ($d->{Antecedent} =~ /="(.*)"/);
	@dependent = ($d->{Dependent} =~ /="(.*)"/);
	#print $antecedent[0],"      :    ",$dependent[0],"\n";
	$h{$antecedent[0]} = [] unless $h{$antecedent[0]};
	push $h{$antecedent[0]}, $dependent[0];

}

for $s (in $srv){
	print "==============\n",$s->{DisplayName},"\n==============\n";
	print "name: ",$s->{Name},"\n";
	print "display name: ",$s->{DisplayName},"\n";
	print "Description: ",$s->{Description},"\n";
	print "Path to Exec: ",$s->{PathName},"\n";
	print "name: ",$s->{Name},"\n";
	print "Starttup type: ",$s->{StartMode},"\n";
	print "State: ",$s->{State},"\n";
	print "Dependent services: ";
	print join (" ",@{$h{$s->{Name}}}) if $h{$s->{Name}};
	print "\n";

	
}