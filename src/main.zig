// https://dev.to/fabioarnold/setup-zig-for-gamedev-2bmf
const std = @import("std");

const c = @cImport({
    @cInclude("SDL.h");
});

pub fn main() !void {
    _ = c.SDL_Init(c.SDL_INIT_VIDEO);
    defer c.SDL_Quit();

    const window = c.SDL_CreateWindow("hello gamedev", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, 640, 400, 0);
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(window, 0, c.SDL_RENDERER_PRESENTVSYNC);
    defer c.SDL_DestroyRenderer(renderer);

    mainloop: while (true) {
        var sdl_event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&sdl_event) != 0) {
            switch (sdl_event.type) {
                c.SDL_QUIT => break :mainloop,
                else => {},
            }
        }

        _ = c.SDL_SetRenderDrawColor(renderer, 0xff, 0xff, 0xff, 0xff);
        _ = c.SDL_RenderClear(renderer);
        var rect = c.SDL_Rect{ .x = 0, .y = 0, .w = 60, .h = 60 };
        const tick = @as(f32, @floatFromInt(c.SDL_GetTicks()));

        const a = @as(f32, 0.001 * tick);

        const t = 2 * std.math.pi / 3.0;
        const r = 100 * @cos(0.1 * a);
        const a_cos = @cos(a);

        _ = a_cos;
        rect.x = 290 + @as(i32, @intFromFloat(r * @cos(a)));
        rect.y = 170 + @as(i32, @intFromFloat(r * @sin(a)));
        _ = c.SDL_SetRenderDrawColor(renderer, 0xff, 0, 0, 0xff);
        _ = c.SDL_RenderFillRect(renderer, &rect);
        rect.x = 290 + @as(i32, @intFromFloat(r * @cos(a + t)));
        rect.y = 170 + @as(i32, @intFromFloat(r * @sin(a + t)));
        _ = c.SDL_SetRenderDrawColor(renderer, 0, 0xff, 0, 0xff);
        _ = c.SDL_RenderFillRect(renderer, &rect);
        rect.x = 290 + @as(i32, @intFromFloat(r * @cos(a + 2 * t)));
        rect.y = 170 + @as(i32, @intFromFloat(r * @sin(a + 2 * t)));
        _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0xff, 0xff);
        _ = c.SDL_RenderFillRect(renderer, &rect);
        _ = c.SDL_RenderPresent(renderer);
    }
}

// pub fn main() !void {
//     // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
//     std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

//     // stdout is for the actual output of your application, for example if you
//     // are implementing gzip, then only the compressed bytes should be sent to
//     // stdout, not any debugging messages.
//     const stdout_file = std.io.getStdOut().writer();
//     var bw = std.io.bufferedWriter(stdout_file);
//     const stdout = bw.writer();

//     try stdout.print("Run `zig build test` to run the tests.\n", .{});

//     try bw.flush(); // don't forget to flush!
// }

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }
