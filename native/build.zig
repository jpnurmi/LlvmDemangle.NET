const std = @import("std");

const Target = struct {
    rid: []const u8,
    query: std.Target.Query,
};

const targets: []const Target = &.{
    .{ .rid = "win-x86", .query = .{ .cpu_arch = .x86, .os_tag = .windows } },
    .{ .rid = "win-x64", .query = .{ .cpu_arch = .x86_64, .os_tag = .windows } },
    .{ .rid = "win-arm64", .query = .{ .cpu_arch = .aarch64, .os_tag = .windows } },
    .{ .rid = "linux-x86", .query = .{ .cpu_arch = .x86, .os_tag = .linux, .abi = .gnu } },
    .{ .rid = "linux-x64", .query = .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu } },
    .{ .rid = "linux-arm", .query = .{ .cpu_arch = .arm, .os_tag = .linux, .abi = .gnueabihf } },
    .{ .rid = "linux-arm64", .query = .{ .cpu_arch = .aarch64, .os_tag = .linux, .abi = .gnu } },
    .{ .rid = "linux-musl-x86", .query = .{ .cpu_arch = .x86, .os_tag = .linux, .abi = .musl } },
    .{ .rid = "linux-musl-x64", .query = .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl } },
    .{ .rid = "linux-musl-arm", .query = .{ .cpu_arch = .arm, .os_tag = .linux, .abi = .musleabihf } },
    .{ .rid = "linux-musl-arm64", .query = .{ .cpu_arch = .aarch64, .os_tag = .linux, .abi = .musl } },
    .{ .rid = "osx-x64", .query = .{ .cpu_arch = .x86_64, .os_tag = .macos } },
    .{ .rid = "osx-arm64", .query = .{ .cpu_arch = .aarch64, .os_tag = .macos } },
};

const cpp_sources: []const []const u8 = &.{
    "llvm-project/llvm/lib/Demangle/Demangle.cpp",
    "llvm-project/llvm/lib/Demangle/ItaniumDemangle.cpp",
    "llvm-project/llvm/lib/Demangle/MicrosoftDemangle.cpp",
    "llvm-project/llvm/lib/Demangle/MicrosoftDemangleNodes.cpp",
    "llvm-project/llvm/lib/Demangle/DLangDemangle.cpp",
    "llvm-project/llvm/lib/Demangle/RustDemangle.cpp",
    "llvm_demangle.cpp",
};

const cpp_flags: []const []const u8 = &.{
    "-std=c++17",
    "-fno-exceptions",
    "-fno-rtti",
    "-DNDEBUG",
};

pub fn build(b: *std.Build) void {
    for (targets) |t| {
        const resolved = b.resolveTargetQuery(t.query);

        const mod = b.createModule(.{
            .target = resolved,
            .optimize = .ReleaseFast,
            .link_libcpp = true,
        });

        mod.addCSourceFiles(.{
            .files = cpp_sources,
            .flags = cpp_flags,
        });

        mod.addIncludePath(b.path("llvm-project/llvm/include"));

        const lib = b.addLibrary(.{
            .linkage = .dynamic,
            .name = "llvm-demangle",
            .root_module = mod,
        });

        const install = b.addInstallArtifact(lib, .{
            .dest_dir = .{ .override = .{ .custom = t.rid } },
            .implib_dir = .disabled,
            .pdb_dir = .disabled,
        });

        b.getInstallStep().dependOn(&install.step);
    }
}
