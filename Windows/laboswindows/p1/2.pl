#use strict;
use Win32::OLE qw(in with);
my $key;
my $value;
while (($key,$value) = each %INC){

	print "$key: $value\n";

}
