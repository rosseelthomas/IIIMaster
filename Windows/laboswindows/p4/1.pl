use Win32::OLE;
use Win32::OLE::Const;
$Win32::OLE::Warn = 3;
$ws = Win32::OLE->new("WbemScripting.SWbemLocator");

%h = %{Win32::OLE::Const->Load($ws)};

while (($k,$v) = each %h){

	print "$k : $v\n";

}