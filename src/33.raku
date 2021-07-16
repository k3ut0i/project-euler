sub print_fractions () {
    my (@ns, @ds);
    for (1 .. 9) -> $n1 {
	for (0 .. 9) -> $n0 {
	    for (1 .. 9) -> $d1 {
		for (0 .. 9) -> $d0 {
		    my $n = $n1*10+$n0;
		    my $d = $d1*10+$d0;
		    next if $d == 0;
		    next if $n >= $d;
		    next if $n1/$n0 == $d1/$d0;
		    next unless ($n1 == $d0) || ($n0 == $d1);
		    if (($n1*$d1*10 == $n0*$d1*9+$n0*$d0) || ($n1*$d1*10 == $n1*$d0*9+$n0*$d0))
		    {
			print "$n / $d\n";
			@ns.push($n); @ds.push($d);
		    }
		    
		}
	    }
	}
    }
    # Could not figure out how to use rationals in raku
    print @ns.reduce(&infix:<*>), "/", @ds.reduce(&infix:<*>), "\n";
}
