use Win32::OLE qw(in with);
$cdo = Win32::OLE->new("CDO.Message");
$excel = Win32::OLE->new("Excel.Sheet");
print Win32::OLE->EnumAllObjects(sub{ my $o = shift; print ref $o; print "\n"; print Win32::OLE->QueryObjectType($o); print "\n"; print "\n"; })