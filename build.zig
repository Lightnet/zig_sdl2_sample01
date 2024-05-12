// https://dev.to/fabioarnold/setup-zig-for-gamedev-2bmf
const std = @import("std");
//const Sdk = @import("SDL_zig"); // Import the Sdk at build time

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // const lib = b.addStaticLibrary(.{
    //     .name = "zig_sdl2",
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // b.installArtifact(lib);

    // Create a new instance of the SDL2 Sdk
    //const sdk = Sdk.init(b, null);

    const exe = b.addExecutable(.{
        .name = "zig_sdl2",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    //sdk.link(exe, .dynamic); // link SDL2 as a shared library
    // Add "sdl2" package that exposes the SDL2 api (like SDL_Init or SDL_CreateWindow)
    //exe.root_module.addImport("sdl2", sdk.getNativeModule());

    const sdl_path = "lib\\sdl2\\";
    exe.addIncludePath(b.path(sdl_path ++ "include"));
    exe.addLibraryPath(b.path(sdl_path ++ "lib\\x64"));
    b.installBinFile(sdl_path ++ "lib\\x64\\SDL2.dll", "SDL2.dll");
    exe.linkSystemLibrary("SDL2");
    exe.linkLibC();

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // const lib_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/root.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    // const exe_unit_tests = b.addTest(.{
    //     .root_source_file = b.path("src/main.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    // const test_step = b.step("test", "Run unit tests");
    // test_step.dependOn(&run_lib_unit_tests.step);
    // test_step.dependOn(&run_exe_unit_tests.step);
}
