const std = @import("std");
const expect = std.testing.expect;

fn divisors_sum(n: u64) u64 {
    const nf: f64 = @intToFloat(f64, n);
    const r: u64 = @floatToInt(u64, @sqrt(nf));
    var i: u64 = 2;
    var sum: u64 = 1;
    while (i <= r) : (i += 1) {
        if (n % i == 0) {
            sum += i + n / i;
        }
    }
    if (r * r == n) sum -= r; // remove double count if square
    return sum;
}

const NumT = enum {
    perfect, deficient, abundant
};

fn num_type(n: u64) NumT {
    const sum = divisors_sum(n);
    if (sum == n) {
        return NumT.perfect;
    } else if (sum < n) {
        return NumT.deficient;
    } else {
        return NumT.abundant;
    }
}

fn all_abundant_nums(n: u64) []u64 { // TODO:
    // All abundant numbers below n
    var as: []u64;
}

fn abundant_sum(n: u64, a: []u64) bool {
    // Search if n can be written as a sum of two elements of as
}

pub fn main() void {
    var i: u64 = 2;
    while (i <= 30) : (i += 1) {
        std.debug.print("{d} -> {d}\n", .{ i, num_type(i) });
    }
}
