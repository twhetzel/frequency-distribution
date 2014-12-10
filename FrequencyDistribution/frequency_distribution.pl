#!/usr/bin/perl

###############################################
# Generate frequency distribution given a
# file as input of labels and counts
#
# Author: Trish Whetzel (plwhetzel@gmail.com)
# Date: Tue Dec  9 15:22:43 PST 2014
##############################################

use strict;
use warnings;

open( DATAFILE, "YourDataFile");
open( OUTFILE, "YourDataFile");

read_file();
print "** DONE ** \n";

##########################
# Read in data file
##########################
sub read_file {
	my @result_count;
	my $i = -1;    #use to skip header line in file

	while (<DATAFILE>) {
		$i++;
		if ( $i > 0 ) {    #account for header line
			my @lines = split( '\t', $_ );
			#print $lines[2];
			push( @result_count, $lines[2] );
		}
	}
	# Generate frequency
	get_frequency(@result_count);
}

############################
# Generate frequency data
############################
sub get_frequency {
	my @path_values = @_;
	#print STDERR "PATH-SIZES Freq:  @path_values\n";

	# Generate frequency data
	my $freq;
	my @data = @path_values;

	my @bins = ( 0, 1, 10, 100, 1000 );
	my %freq = map { $_ => 0 } @bins;

	for my $d (@data) {
		for my $b ( reverse @bins ) {
			do { $freq{$b}++; last } if $d >= $b;
		}
	}

	for my $key ( sort { $a <=> $b } keys %freq ) {
		print STDERR "$key\t$freq{$key}\n";
		print OUTFILE "$key\t$freq{$key}\n";
	}
	print STDERR "\n";
}
