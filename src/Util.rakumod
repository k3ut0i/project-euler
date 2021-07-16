unit module Util;

sub factorial($n) is export {(1..$n).reduce: &infix:<*>;}

sub digits($n) is export {
    my @d; my $r = $n;
    while ($r > 0) {
	@d.unshift($r % 10);
	$r = floor($r / 10);
    };
    return @d;
}

sub foldl($block, $list, $init) is export {
    my $acc = $init;
    for $list.list -> $e {
	$acc = $block($acc, $e);
    }
    return $acc;
}

sub cnt($block, $range) is export {
    # Count how many times the block is true for the elements of the range
    my $c = 0;
    for $range.list -> $n {
	$c++ if $block($n);
    }
    return $c;
}
