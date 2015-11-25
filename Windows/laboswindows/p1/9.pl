use Win32::OLE qw(in with);
use Win32::OLE::Const;
$h = Win32::OLE::Const->Load($ARGV[0]);
while (($k,$v) = each %{$h}){

	print "$k : $v\n";
}