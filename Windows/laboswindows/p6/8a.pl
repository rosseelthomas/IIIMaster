# implementatie bind_object functie: zie sectie 5

use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";
my $AdsPath = "OU=EM7INF,OU=Studenten,OU=iii,DC=iii,DC=hogent,DC=be";
my $obj     = bind_object($AdsPath);
print "--------------------ADSI-------------------------------\n";
print  "Adspath (ADSI) = " ;
printinhoud ($obj->{ADsPath});

print  "class (ADSI)   = ";
printinhoud ($obj->{class});

print  "GUID (ADSI)    = ";
printinhoud ($obj->{GUID});

print "--------------------LDAP-------------------------------\n";
print  "distinguishedName (LDAP) = " ;
printinhoud ($obj->{distinguishedName});

print  "objectclass (LDAP)       = ";
printinhoud ($obj->{objectclass});

print  "objectGUID (LDAP)        = ";
printinhoud (sprintf ("%*v02X ","",$obj->{objectGUID}));

sub printinhoud{
   my $inhoud=shift;
   if (ref $inhoud) {
       print "Array met " , scalar @{$inhoud} , " elementen :\n\t" ;
       print join("\n\t", @{$inhoud});
   }
   else {
       print "$inhoud";
   }
   print "\n";
}


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