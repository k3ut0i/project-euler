# Digit factorials
my @f = (1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880);

sub dig_fac ($d) {return @f[$d]};

sub digits($n) {
    my @d; my $r = $n;
    while ($r > 0) {
	@d.unshift($r % 10);
	$r = floor($r / 10);
    };
    return @d;
}

sub is-df($n) {
    return $n == digits($n).map(&dig_fac).sum;
}

## Full brute search with a very conservative upper bound for the search
## after the sixth digit, any extra digit will increase the number above 9!
## thus the number can have atmost 6 digits.
sub sum_all_df {
    my $s = 0;
    for 3 .. 1_000_000 -> $n {
	if is-df($n) {
	    $s += $n;
	    printf "%d\n", ($n);
	};
    }
    return $s;
}
