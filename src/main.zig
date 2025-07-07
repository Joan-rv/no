const std = @import("std");
const mem = std.mem;

fn print_version() !void {
    const stdout = std.io.getStdOut();
    try stdout.writeAll("Version 0.1.0\n");
}
fn print_help(arg0: []const u8) !void {
    const stdout = std.io.getStdOut();
    try stdout.writeAll(arg0);
    try stdout.writeAll(" [STRING]\n");
}

pub fn main() !void {
    var out: [:0]const u8 = "n";
    var args = std.process.args();
    const arg0 = args.next();
    while (args.next()) |arg| {
        if (mem.eql(u8, "--version", arg)) {
            try print_version();
            return;
        } else if (mem.eql(u8, "--help", arg)) {
            try print_help(arg0 orelse "no");
            return;
        } else {
            out = arg;
        }
    }

    const stdout = std.io.getStdOut();
    while (true) {
        try stdout.writeAll(out);
        try stdout.writeAll("\n");
    }
}
