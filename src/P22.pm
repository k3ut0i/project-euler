#!/usr/bin/perl
package P22;
use strict;
use warnings;

sub value{ #map reduce in a language with strings as list of chars
  my $name = shift;
  my $len = length $name;
  my $score = 0; my $idx = -1;
  $score += ord(substr $name, $idx, 1) while ++$idx < $len; #sum ascii vals
  return $score-$len*64; #remove ascii offsets for chars
}

sub removequotes { # remove first and last chars
  my $s = shift;
  substr $s, 1, (length $s)-2;
}

sub readnames{ # give sorted list of names from a csv file
  my $fname = shift;
  open(my $fh, "<", $fname)
    or die "Failed to open $fname: $!\n";
  my @names = map {removequotes $_} split(",", <$fh>);
  return sort @names;
}

sub total_score{
  my @array = @_;
  my $ts = 0;my $idx = -1; my $len = scalar @array;
  $ts += ($idx+1) * value($array[$idx]) while ++$idx < $len;
  return $ts;
}
#  perl -I./src -MP22 -e 'my @array = P22::readnames("inputs/p022_names.txt"); print P22::total_score(@array)'
1;
