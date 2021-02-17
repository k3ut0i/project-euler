#!/usr/bin/perl
package P17;

use strict;
use warnings;

our %nummap =
  (
   1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
   6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
   11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
   15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen',
   19 => 'nineteen',
   20 => 'twenty', 30 => 'thirty', 40 => 'forty', 50 => 'fifty',
   60 => 'sixty', 70 => 'seventy', 80 => 'eighty', 90 => 'ninety',
   100 => 'hundred', 1000 => 'thousand'
  );

sub ones_str{
  my $n = shift; die "digit required: got $n\n" unless 0 <= $n <= 9;
  if ($n == 0) {
    return '';
  } else {
    return $nummap{$n}
  }
}

sub tens_str{
  my $n = shift; die "tens required digits b/w 3 and 9: got $n\n" unless 3 <= $n <= 9;
  return $nummap{$n*10}
}

sub tens_ones_str{
  my $n = shift; die "less than 100 req: got $n\n" unless $n < 100;
  if (10 <= $n <= 19) {
    return $nummap{$n};
  } elsif (0 <= $n <= 9) {
    return ones_str($n);
  } else { # 20 <= $n <= 99
    my $ones = ones_str($n % 10);
    my $tens = $nummap{($n - $n % 10)};
    return $tens if $ones eq '';
    return $tens . " " . $ones;
  }
}

sub hundreds_str{
  my $n = shift; die "required digit: got $n\n" unless 0 <= $n <= 9;
  if ($n == 0) {
    return ''
  } else {
    return ones_str($n) . ' ' . $nummap{100};
  }
}

sub thousands_str{
  my $n = shift; die "required digit: got $n\n" unless 0 <= $n <= 9;
  if ($n == 0) {
    return ''
  } else {
    return ones_str($n) . ' ' . $nummap{1000};
  }
}

sub num_literal {
  use integer;
  my $num = shift;
  my $ones = $num % 10;
  my $tens = (($num - $num % 10) % 100) / 10;
  my $tens_ones = $num % 100; #required for 11 12 etc..
  my $hundreds = (($num - $num % 100) % 1000) / 100;
  my $thousands = (($num - $num % 1000) % 10000) / 1000;
  my $thousands_str = thousands_str($thousands);
  my $hundreds_str = hundreds_str($hundreds);
  my $tens_ones_str = tens_ones_str($tens_ones);

  if ($tens_ones_str eq '') {
    if ($hundreds_str eq '') {
      return $thousands_str;
    } elsif ($thousands_str eq '') {
      return $hundreds_str;
    } else {
      return $thousands_str . ' ' . $hundreds_str;
    }
  } else {
    if (($hundreds_str eq '') and ($thousands_str eq '')) {
      return $tens_ones_str;
    } elsif ($thousands_str eq '') {
      return $hundreds_str . ' and ' . $tens_ones_str;
    } elsif ($hundreds_str eq '') {
      return $thousands_str . ' and ' . $tens_ones_str;
    } else {
      return $thousands_str . ' ' . $hundreds_str . ' and ' . $tens_ones_str;
    }
  }
}

sub count_chars{
  my $s = shift;
  return length $s=~s/ //gr;
}

sub count_all_chars{
  my $score = 0;
  for (1 .. 1_000) {
    $score += count_chars(num_literal($_));
  }
  return $score;
}
1;
