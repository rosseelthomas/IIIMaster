use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";
$reg = $ARGV[0] || "";

$h = Win32::OLE::Const->Load("Active DS Type Library");
for $k(sort keys %{$h}){
	print "$k : $h->{$k}\n" if $k =~ /$reg/;
}