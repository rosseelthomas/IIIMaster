#de foreach-lus uit vorige oefening wordt aangepast:

use Win32::OLE qw(in with);
$Win32::OLE::Warn = 3;
 $name = $ARGV[0] || "test.xls";
 $fso = Win32::OLE->new("Scripting.FileSystemObject");
 $excel = Win32::OLE->new("Excel.Application","quit");
$wb = $excel->{Workbooks}->open($fso->GetAbsolutePathName("$name"));


for $nsheet (in $wb->Sheets){

 print "\n$nsheet->{name}\n";
    $range=$nsheet->{UsedRange};
    $mat = $range->{Value};
    if (ref $mat) {   #controleren op het aantal rijen en kolommen is niet juist voor een leeg werkblad.
       print "matrix met $range->{rows}->{Count} rijen en $range->{columns}->{Count} kolommen\n";
       print join("  \t",@{$_}),"\n" foreach @{$mat};
    }
    else {
       ($mat ? print "1 inhoud : $mat\n": print "leeg werkblad\n");
    }
    print "\n-----------------------------------------\n";
}