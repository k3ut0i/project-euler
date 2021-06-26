sub man-div($a, $b) {
    my $q = $a div $b;
    my $r = $a % $b;
    my $limit = 50;
    my @digits;
    my @residues;
    my $n = $r;
    while 1 {
	last if $n (elem) @residues;
	@residues.push($n);
	$n *= 10;
	if $n < $b {
	    @digits.push(0);
	} else {
	    @digits.push($n div $b);
	    $n = $n % $b;
	}
    }
    my $idx = 0;
    for @residues -> $residue {
	if $residue == $n {$idx++; last};
    }
    return ($q, $idx, @digits);
}

sub max-recurring-cycle ($l) {
    my $max = 0; my $max_num = 1; 
    for (2..$l) {
	my $x = man-div(1, $_); # I do not understand why list assignment is not working perl-style
	my $q = $x[0];
	my $recur_start = $x[1];
	my @digits = $x[2];

	my $len = @digits.elems() - $recur_start + 1;
#	print "$x - $len\n";
	if $max < $len {$max = $len; $max_num = $_};
    }
    return ($max, $max_num);
}
