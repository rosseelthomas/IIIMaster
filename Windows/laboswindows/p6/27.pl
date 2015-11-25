# implementatie bind_object functie: zie sectie 5
use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";
$Win32::OLE::Warn=1;
my $RootObj = bind_object("RootDSE");

$domain = $RootObj->get(defaultNamingContext);

$obj = bind_object("ou=Studenten,ou=iii,$domain");
$obj->{Filter} = ["OrganizationalUnit"];
for $s(in $obj){
	$s->GetInfoEx(["ou","msDS-Approx-Immed-Subordinates"],0);
	$val = $s->Get("msDS-Approx-Immed-Subordinates");
	print $s->{ou}," : $val\n";
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