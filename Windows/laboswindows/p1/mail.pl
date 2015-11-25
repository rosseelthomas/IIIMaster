use Win32::OLE qw (in with);
$Win32::OLE::Warn = 3;
$mail = Win32::OLE->new("CDO.Message");
$mail->{Sender} = "rosseel.thomas\@gmail.com";
$mail->{To} = "rosseel.thomas\@ugent.be";
$mail->{Subject} = "wmi test";
$mail->{TextBody} = "dit is een test";
#$mail->Send;


$conf = Win32::OLE->new("CDO.Configuration");
print "aantal: ".$conf->Fields->Count."\n";
for $field  (in $conf->Fields){

	print Win32::OLE->QueryObjectType($field);
	print "\n";
}

for $field  (in $conf->Fields){

	print "$field->{name} : $field->{value}";
	print "\n";
}

$conf->Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver")->{Value}     = "smtp.telenet.be"; #thuis aanpassen
   $conf->Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")->{Value} = 25;               #niet noodzakelijk
   $conf->Fields("http://schemas.microsoft.com/cdo/configuration/sendusing")->{Value}      = 2;
   $conf->{Fields}->Update();      #is noodzakelijk

    $mail->{Configuration}=$conf;  #moet ingevuld worden

    $mail->Send;