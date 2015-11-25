$file = $ARGV[0] || "file.txt";
use Win32::OLE qw(in with);
$fso = Win32::OLE->new("Scripting.FileSystemObject");
$f = $fso->GetFolder(".");

print "totaal buiten de kwestie, maar hier zijn de files in de huidige folder\n";

for $fi (in $f->Files){

	print $fi->Name;
	print " ";
	print $fi->Type;
	print "\n";
}
print "\n==========================\n";

if($fso->FileExists($file)){

	$fi = $fso->GetFile($file);
	print $fi->Path;
	print "\n";	

}

