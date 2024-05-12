# zig_sdl2_sample01

# SDL:
 - Version 2.30.3
 
# Zig:
 - Version 0.12.0

# Information:
 Using SDL2 dll.

# Set Up:
 Download SDL3 from github.
```
-lib // zig default
--sdl3 // folder
---include
---lib
```
It config in build.zig

```
zig build
```

```
zig build run
```

# Ref example:
 - https://dev.to/fabioarnold/setup-zig-for-gamedev-2bmf

# Notes:

```
  Convert c to zig type float, integer.
```
```
                // int      <         float
rect.x = 290 + @as(i32, @intFromFloat(r * @cos(a)));
```
Old
```
rect.x = 290 + @floatToInt(i32, r * @cos(a));
rect.y = 170 + @floatToInt(i32, r * @sin(a));
```
New
```
rect.x = 290 + @as(i32, @intFromFloat(r * @cos(a)));
rect.y = 170 + @as(i32, @intFromFloat(r * @sin(a)));
```

# Set Up:
 - https://dev.to/fabioarnold/setup-zig-for-gamedev-2bmf
 - https://github.com/andrewrk/sdl-zig-demo
 - https://github.com/MasterQ32/SDL.zig
 - https://github.com/MasterQ32/SDL.zig/archive/55caabfff7c03e42a4c6563e0f6d16cc8fa26dd6.tar.gz

