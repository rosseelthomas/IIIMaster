# implementatie bind_object functie: zie sectie 5
use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";

my $RootObj = bind_object("RootDSE");

$RootObj->GetInfoEx([qw (Name Class GUID ADSPath Parent Schema defaultNamingContext dnsHostName)],0);

printf "%-10s : %s\n", $_ , $RootObj->{$_} foreach qw (Name Class GUID ADSPath Parent Schema defaultNamingContext dnsHostName); 
#De ADSI-attributen Class en Schema zijn niet ingevuld omdat RootDSE niet overeenkomt met een AD object
#verwissel defaultNamingContext dnsHostName om alle uitvoer te zien.

#In PowerShell heb je daar geen last van...


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
