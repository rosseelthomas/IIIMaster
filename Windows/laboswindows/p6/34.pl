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


# •het LDAP-attribuut is multi-valued : !isSingleValued
# •het LDAP-attribuut wordt opgenomen in de Global Catalog : isMemberOfPartialAttributeSet
# •het LDAP-attribuut laat indexering toe : searchFlags  & 1
# •het LDAP-attribuut wordt niet gerepliceerd tussen domeincontrollers : 
# •het LDAP-attribuut is geconstrueerd op basis van andere attributen
# •het LDAP-attribuut heeft een ondergrens en/of bovengrens
# •het LDAP-attribuut is Microsoft specifiek (voor Active Directory)
# •het LDAP-attribuut kan niet gewijzigd worden


sub overloop {
	
	my $p = shift;
	my $part = bind_object($p);


	for $class(in $part){

		my $c = $class;
		if($c){
			
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