const std = @import("std");

pub fn main() !void {
    std.debug.print("I like {s}s!.\n", .{"banana"});
    const x = @embedFile("input");
    var numbers = std.mem.tokenizeScalar(u8, x, ' ');
    while (numbers.next()) |num| {
        const n = try std.fmt.parseInt(u32, num, 10);
        std.debug.print("{d}\n", .{n});
    }
    //std.debug.print("{d}\n", .{numbers});
    while (.{numbers.next(), numbers.next}) |.{num1, num2}| {}
}
