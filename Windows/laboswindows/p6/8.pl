
use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";
binmode(STDOUT, ":utf8");
$o = bind_object("CN=Thomas Rosseel,OU=EM7INF,OU=Studenten,OU=iii,DC=iii,DC=hogent,DC=be");


print "ADSI:----------\n";
print "GUID: ",$o->{"GUID"};
print "\nName: ",$o->{"ADsPath"},"\n";
print "Class: ", $o->{"Class"},"\n";

print "LDAP:----------\n";
print "GUID: ";
print sprintf ("%*v02X ", "", $o->{"objectGUID"});
print "\nName: ",$o->{"distinguishedName"},"\n";
print "Class: ", (join " ",@{$o->{"objectClass"}}),"\n";



sub bind_object{

my $in = shift;

my $obj;

if($ENV{USERDOMAIN} eq "III"){
	$moniker = (($in =~ /^LDAP:/) ? "" : "LDAP://").$in;
	$obj = Win32::OLE->GetObject($moniker);

}else{
	$ip = "193.190.126.71";
	$moniker = (($in =~ /^LDAP:/) ? "" : "LDAP://").$ip."/".$in;
    $ldap = Win32::OLE->GetObject("LDAP:");
	$obj = $ldap->OpenDSObject($moniker,"Thomas Rosseel","eeza9rie",0);
}

return $obj;

}



