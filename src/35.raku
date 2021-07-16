sub all-rotations($n) {
    my @r = (); my $c = $n;
    my $ndigits = ceiling($n.log10);
    for ^$ndigits {
	$c = floor($c/10) + ($c % 10) * 10**($ndigits-1);
	@r.push($c);
    }
    return @r;
}

sub circular-prime($n) {
    all-rotations($n).map(&is-prime).reduce(-> $a, $b {$a && $b});
}

sub is-cp-direct ($n) {
    my $r = True; my $c = $n;
    my $ndigits = ceiling($n.log10);
    for ^$ndigits {
	$c = floor($c/10) + ($c % 10) * 10**($ndigits-1);
	$r = $r && $c.is-prime;
	last unless $r;
    }
    return $r;
}

# use Util
# cnt(&is-cp-direct, 2..1_000_000)
