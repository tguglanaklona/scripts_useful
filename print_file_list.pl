#!/usr/bin/perl
use strict;


my @flist = glob "data_*.xlsx";
$_ = substr($_,5,index($_,".xlsx")-5) for(@flist);
print "'$_', " for(@flist);


