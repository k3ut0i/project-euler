sub sum_power($n, $e) {
    my @digits; my $num = $n;
    while $num != 0 {
	@digits.push($num % 10);
	$num = $num div 10;
    }
    @digits.map(-> $x {$x**$e}).sum;
}

sub find_nums($e) {
    my $limit = 5*9**$e;
    my @nums;
    for 2..$limit {
	if sum_power($_, $e) == $_ {@nums.push($_)}
    }
    @nums.sum();
}
