#/usr/bin/perl


use IO::Socket;
use strict;

my $sock = IO::Socket::INET->new(
    Proto    => 'udp',
    PeerPort => 5060,
    PeerAddr => '46.101.55.90',
) or die "Could not create socket: $!\n";

my $filename = 'udp.message.txt';
open( FILE, '<', $filename ) or die 'Could not open file:  ' . $!;

undef $/;
my $whole_file = <FILE>;

#$sock->send($whole_file) or die "Send error: $!\n";

$sock->send("A"x100 . " " . "B"x100 . " " . "C"x100 . "\r\n") or die "Send error: $!\n";
