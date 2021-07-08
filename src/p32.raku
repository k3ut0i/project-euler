# Pandigital Products

sub get-pan (@a) {
    my ($a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9) = @a;
    my @result = ();

    my $A0 = $a1;
    my $B0 = $a2*1000+$a3*100+$a4*10+$a5;
    my $C0 = $a6*1000+$a7*100+$a8*10+$a9;
    @result.push([$A0, $B0, $C0]) if $A0*$B0 == $C0;

    my $A1 = $a1*10+$a2;
    my $B1 = $a3*100+$a4*10+$a5;
    my $C1 = $a6*1000+$a7*100+$a8*10+$a9;
    @result.push([$A1, $B1, $C1]) if $A1*$B1 == $C1;

    return @result;
}
my @all = ();

for (1..9).permutations {
    my @p = get-pan($_);
    @all.append(@p);
    @p.say if @p;
}

my $ans = @all.map(-> $a {$a[2]}).unique.sum;
