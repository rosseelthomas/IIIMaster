use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";


$partitie = "schema";
# $partitie = $root->{SchemaNamingContext};

#print bind_object($partitie)->Get(distinguishedName);

for $o(in bind_object($partitie)){


	 $h{$o->{Class}}++;


}

while (($k,$v) = each %h){
	print "$k : $v\n";
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
