use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";

$root = bind_object("RootDSE");
$root->{dnsHostName};


$partitie = $root->{defaultNamingContext};


$classes{bind_object($partitie)->{Class}}++;
geefobjecten($partitie,0);
for $c(sort keys %classes){
	print "$c => $classes{$c}\n";
}

#geefobjecten($partitie,0);



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

sub geefobjecten {
	my $part = shift;
	my $tabs = shift;
	if($tabs>-1){
		my $o = bind_object($part) or return;
		$classes{$o->{Class}}++;
		for $n(in $o){
			 #print "\t" for (1..$tabs);
			 #print $n->{distinguishedName},"\n";

			 geefobjecten($n->{distinguishedName}, $tabs+1);
		}
	}
}