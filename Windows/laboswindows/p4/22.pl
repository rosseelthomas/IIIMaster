use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("WbemScripting.SwbemLocator");
$service = $locator->connectserver(".","root/cimv2");

$| = 1;

$dir = "c:";
 my $objs = $service->ExecQuery("select * from Win32_Directory where Name='$dir' ");
	my ($obj) = in $objs;
print DirectorySize($obj, 2,0);

sub DirectorySize {
	my ($o,$depth,$tabs) = @_;

	print "\t" for 1..$tabs;
	print $o->{Name},"\n";
	
	my $files = $service->ExecQuery ("ASSOCIATORS OF {Win32_Directory='$o->{Name}'} where AssocClass=CIM_DirectoryContainsFile ");
	my $size = 0;
	for $f (in $files){
		$size += $f->{FileSize}; 
	}
	if($depth>0){
		my $subfolders = $service->ExecQuery ("ASSOCIATORS OF {Win32_Directory='$o->{Name}'} where AssocClass=Win32_SubDirectory  Role=GroupComponent");
		for $s (in $subfolders) {
			$size += DirectorySize($s, $depth-1,$tabs+1);
		}
	}
	
	$size;

}
