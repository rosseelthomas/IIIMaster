use Win32::OLE qw(in with);
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$locator = Win32::OLE->new("WbemScripting.SWbemLocator");

getnamespaces("root/cimv2");


sub getnamespaces {

	my $namespace = $_[0];
	my $services = $locator->ConnectServer(".","$namespace");
	for my $n (in $services->InstancesOf("__NAMESPACE")) {
		my $new = $namespace."/".$n->{Name};
		print "$new\n";
		getnamespaces($new);
	}


}