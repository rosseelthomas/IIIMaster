use Win32::OLE qw(in with);

$excel = Win32::OLE->new("Excel.Sheet");
use Win32::OLE::Const;
$h = Win32::OLE::Const->Load($excel);
while (($k,$v) = each %{$h}){

	print "$k : $v\n";
}