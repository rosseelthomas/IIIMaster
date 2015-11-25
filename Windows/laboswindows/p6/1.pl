use Win32::OLE 'in';
use Win32::OLE::Const;

$h = Win32::OLE::Const->Load("Active DS Type Library");
while(($k,$v) = each %{$h}){
	print "$k : $v\n" if $k =~  /ADS_/;
}
