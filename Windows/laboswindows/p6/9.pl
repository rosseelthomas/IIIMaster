
use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";

$o = bind_object("CN=Thomas Rosseel,OU=EM7INF,OU=Studenten,OU=iii,DC=iii,DC=hogent,DC=be");

@arr = ("mail","givenName","sn","displayName","homeDirectory","scriptPath","profilePath","logonHours","userWorkstations");

for (@arr){
	print $_," : ";
	printinhoud($o->{$_});
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


sub printinhoud {
	my $in = shift;
	if(ref($in) eq "ARRAY"){
		print join " ",$in;
	}else{
		print $in;
	}
}
