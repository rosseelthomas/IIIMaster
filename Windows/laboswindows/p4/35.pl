use Win32::OLE qw(in with);
$locator = Win32::OLE->new("wbemscripting.swbemlocator")