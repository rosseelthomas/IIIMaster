use Win32::OLE qw(in with);
$Win32::OLE::Warn=3;
$locator = Win32::OLE->new("Wbemscripting.Swbemlocator");
$service=$locator->connectserver(".","root/cimv2");
use Win32::OLE::Const 'Microsoft WMI Scripting';



$shares = $service->Get("Win32_Share",wbemFlagUseAmendedQualifiers);
$method = $shares->{Methods_}->Item("Create");
$in = $method->{InParameters};
$in->{Path} = "c:\\Perl";
$in->{Name} = "Perlshare";
$in->{Type} = 0;
#$ret = $shares->ExecMethod_("Create",$in);
%h = maakhash($method); 
#print $h{$ret->{ReturnValue}},"\n";





sub maakhash {
	$obj = $_[0];

	my %hash;
	@hash{@{$obj->{Qualifiers_}->{ValueMap}->{Value}}} = @{$obj->{Qualifiers_}->{Values}->{Value}};
	return %hash;

}