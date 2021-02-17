const std = @import("std");
const expect = std.testing.expect;

fn leap_year(n: u16) bool {
    const d4: bool = (n % 4) == 0;
    const d100: bool = (n % 100) == 0;
    const d400: bool = (n % 400) == 0;
    if (d400) {
        return true;
    } else if (d100) {
        return false;
    } else if (d4) {
        return true;
    } else {
        return false;
    }
}

test "leap years" {
    expect(leap_year(0) == true);
    expect(leap_year(1) == false);
    expect(leap_year(300) == false);
    expect(leap_year(1200) == true);
}

fn month_days(m: u4, leap: bool) u5 {
    return switch (m) {
        4, 6, 9, 11 => 30,
        2 => if (leap) @as(u5, 29) else @as(u5, 28),
        else => 31,
    };
}

test "days in a month" {
    expect(month_days(1, false) == 31);
    expect(month_days(2, false) == 28);
    expect(month_days(2, true) == 29);
    expect(month_days(4, true) == 30);
    expect(month_days(10, false) == 31);
}

fn first_sundays(leap: bool, start: u4) u4 {
    var i: u4 = 1;
    var day: u9 = start;
    var count: u4 = 0;
    while (i <= 12) : (i += 1) {
        if (day == 0) count += 1;
        day = (day + month_days(i, leap)) % 7;
    }
    return count;
}

test "first sundays" {
    expect(first_sundays(leap_year(1900), 1) == 2);
    expect(first_sundays(leap_year(2000), 6) == 1);
}

fn first_sundays_interval(start_year: u16, end_year: u16, start: u4) u64 {
    var y: u16 = start_year;
    var day: u4 = start;
    var count: u64 = 0;
    while (y <= end_year) : (y += 1) {
        const leap = leap_year(y);
        count += first_sundays(leap, day);
        day = (day + if (leap) @as(u3, 2) else @as(u3, 1)) % 7;
    }
    return count;
}

test "all sundays" {
    expect(first_sundays_interval(1900, 1902, 1) == 5);
}

pub fn main() void {
    const sundays: u64 = first_sundays_interval(1901, 2000, 2);
    std.debug.print("{d}\n", .{sundays});
}
