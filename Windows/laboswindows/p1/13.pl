use Net::SMTP;

$smtp = Net::SMTP->new('smtp.telenet.be');   #stel thuis de correcte smtp-server in 

$smtp->mail('thomas.rosseel@ugent.be');
$smtp->to('thomas.rosseel@ugent.be');

$smtp->data();
$smtp->datasend("Subject: testje met smtp\n");
$smtp->datasend("test\n");
$smtp->dataend();
$smtp->quit;