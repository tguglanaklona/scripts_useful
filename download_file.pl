#/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;

my $url = 'http://www.google.com';
my $file = './txt/outfile';

getstore($url, $file);




