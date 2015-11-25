use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";

$root = bind_object("RootDSE");
$root->{dnsHostName};


$domain =  $root->{defaultNamingContext};

$users = bind_object("CN=Users,$domain");
$users->{filter} = ["user"];
for $user(in $users){
	print "naam : ",$user->{cn},"\n";
	print "account disabled\n" if $user->{AccountDisabled};
	print "disable:  ",($user->{UserAccountControl} & ADS_UF_ACCOUNTDISABLE) ? "1":"0","\n";
	print "password required\n" if $user->{PasswordRequired};
	print "password not requried: ",($user->{UserAccountControl} & ADS_UF_PASSWD_NOTREQD) ? "1":"0","\n";

	print "==========\n";
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
