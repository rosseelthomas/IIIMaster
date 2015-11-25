use Win32::OLE;
Win32::OLE->new("Message");
print Win32::OLE->LastError;