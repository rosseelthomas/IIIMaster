use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";
$ldap = Win32::OLE->GetObject("LDAP:");

$obj = $ldap->OpenDSObject("LDAP://satan.hogent.be","Thomas Rosseel","eeza9rie",0);

print Win32::OLE->LastError()?"not oke":"oke","\n";