#!/usr/bin/perl
use strict;


my $filename = 'data_5P.xlsx';#'injectors_xslx.txt';

open(my $fh, '+<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
while (my $row = <$fh>) {
  chomp $row;

  print "'$row', ";
}


