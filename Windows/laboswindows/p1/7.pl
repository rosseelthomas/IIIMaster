use Win32::OLE;
$Win32::OLE::Warn = 3;
Win32::OLE->new("Message");
