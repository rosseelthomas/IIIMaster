use Win32::OLE;
use Win32::OLE::Const ".*Excel";


binmode(STDOUT,":utf8");
$excel = Win32::OLE->new("Excel.Application","quit");
$excel->{DisplayAlerts} = 0;
$fso = Win32::OLE->new("scripting.filesystemobject");
$abs = $fso->GetAbsolutePathName(".");
$wb = $excel->{Workbooks}->Open("$abs\\punten.xls");
$wb2 = $excel->{Workbooks}->Open("$abs\\punten2.xls");

$ws = $wb->{WorkSheets}->Item(1);
$ws2 = $wb2->{WorkSheets}->Item(1);
$i=1;
$naam = $range = $ws2->Cells($i,1)->{Value};
$vak2 = $range = $ws2->Cells($i,2)->{Value};
my %hash;
while($naam){

	$hash{$naam} = $vak2;

	$i++;
	$naam = $ws2->Cells($i,1)->{Value};
	$vak2 = $ws2->Cells($i,2)->{Value};

}
$i=1;
$naam = $ws->Cells($i,1)->{Value};

while($naam){

	$mat->[$i-1][0] = $hash{$naam};
	$mat->[$i-1][1] = ($hash{$naam} + $ws->Cells($i,2)->{Value})/2;
	$i++;
	$naam = $ws->Cells($i,1)->{Value};
}

$ws->Range($ws->Cells(1,3),$ws->Cells($i-1,4))->{Value} = $mat;
$mat = $ws->Range($ws->Cells(1,1),$ws->Cells($i-1,4))->{Value};

$nk =5;
$cr = 2;
$fs = $wb->{WorkSheets}->Add();
$fs->{Name}="Ad valvas";

advalvas ("A",12 ,20  );
advalvas ("B",10 , 11.5);
advalvas ("C",7.5, 9.5);
advalvas ("D",0 , 7  );
$fs->{Columns}->Autofit();
$wb->Save();
sub advalvas {
	($text,$min,$max) = @_;
	my @studenten;
	for $row (@{$mat}){
		$name = $row->[0];
		$score = $row->[3];
		if($score>=$min && $score<$max){
			push @studenten,$row->[0];
		}
	}

	$size = @studenten;
	
	$i=1;$j=0;
	$res->[0][2] = $text;
	for $s(@studenten){

		$nr = ($size - $j - 1 - ($size - $j - 1)%$nk)/$nk +1;
	
			$res->[$i][$j] = $s;
	
		++$i;
		if($i>$nr){$i=1;++$j;}

	}

	$maxnr = ($size  - 1 - ($size - 1)%$nk)/$nk +1;
	$fs->Range("A".$cr.":E".($cr+$maxnr))->{Value} = $res;
	$range = $fs->Range("A".$cr.":E".($cr+$maxnr));
	$cr = $cr+$maxnr +2;



	$range->Cells(1,3)->{HorizontalAlignment} = xlCenter;
	$range->Cells(1,3)->{Font}->{Bold}=1;
	$range->Borders(xlEdgeTop)->{LineStyle} = 1;
	$range->Borders(xlEdgeLeft)->{LineStyle} = 1;
	$range->Borders(xlEdgeRight)->{LineStyle} = 1;
	$range->Borders(xlEdgeBottom)->{LineStyle} = 1;



}