use Win32::OLE 'in';
use Win32::OLE::Const "Active DS Type Library";

$root = bind_object("RootDSE");



$domain = $root->Get(SchemaNamingContext);



overloop($domain);


while (($k,$v) = each(%count)){
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


# klasse onmiddelijk afgeleid van top : subClassOf == Top
# is een hulpklasse : objectClassCategory == 3
# kan attirbuten overnemen van een of meer hulpklassen : auxiliaryClass, systemAuxiliaryClass
# de klasse is Microsoft specifiek : governsID begint met 1.2.840.113556
# de klasse kan niet gewijzigd worden : systemOnly
# de objecten van de klasse hebben een RDN die niet van de vorm CN=... is  // cn<=>"Common-Name"

sub overloop {
	
	my $p = shift;
	my $part = bind_object($p);


	for $class(in $part){

		my $c = $class;
		if($c){
			#print $c->Get("subClassOf"),"\n";
			
			# print "name : ",$c->Get("distinguishedName"),"\n";
			# print "sub : ",$c->Get("subClassOf"),"\n";
			# print "aux : ",$c->Get("auxiliaryClass"),"\n";
			# print "sysaux : ",$c->Get("systemAuxiliaryClass"),"\n";
			# print "governsID : ",$c->Get("governsID"),"\n";
			# print "systemOnly : ",$c->Get("systemOnly"),"\n";
			# print "cn : ",$c->Get("cn"),"\n";
			# print "==============================================\n";

			if($c->Get("subClassOf") eq "top" ){
				$count{"subclass of top"}++;
			}

			if($c->Get("objectClassCategory") == 3 ){
					$count{"is hulpklasse"}++;
			}

			if(($c->Get("auxiliaryClass") || $c->Get("systemAuxiliaryClass")) ){
				$count{"kan attirbuten overnemen van hulpklasse"}++;
			}

			if($c->Get("governsID") =~ /^1\.2\.840\.113556/ ){
				$count{"Microsoft specifiek"}++;
			}

			if($c->Get(systemOnly)){
				$count{"niet aanpasbaar"}++;
			}

			if($c->Get("cn") ne "Common-Name"){
				$count{"begint niet met cn"}++;

			}


			overloop($c->Get("distinguishedName"));




		}
	}
}