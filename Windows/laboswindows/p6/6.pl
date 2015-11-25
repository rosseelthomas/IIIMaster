use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";

$o = bind_object("CN=SATAN,OU=Domain Controllers,DC=iii,DC=hogent,DC=be");
@arr = ("AdsPath","Class","GUID","Name","Parent","Schema");

for (@arr){
	print $_," : ",$o->{$_},"\n";
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



