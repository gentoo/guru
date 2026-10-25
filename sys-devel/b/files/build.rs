use std::process::Command;

fn main() {
    // 1. Compile C helper stubs
    cc::Build::new()
        .file("thirdparty/nob.c")
        .file("thirdparty/arena.c")
        .file("thirdparty/jim.c")
        .file("thirdparty/flag.c")
        .file("thirdparty/glob.c")
        .file("thirdparty/jimp.c")
        .file("thirdparty/libc.c")
        .file("thirdparty/shlex.c")
        .file("thirdparty/time.c")
        .include("thirdparty")
        .warnings(false)
        .compile("crust_thirdparty");

	println!("cargo:rustc-link-lib=c");

    // 2. Build and run bgen to generate src/codegen/.INDEX.rs if missing
    if !std::path::Path::new("src/codegen/.INDEX.rs").exists() {
        let status = Command::new("rustc")
            .args(&["src/bgen.rs", "-o", "target/bgen_build"])
            .status()
            .expect("Failed to compile bgen.rs");

        if status.success() {
            Command::new("./target/bgen_build")
                .status()
                .expect("Failed to run bgen");
        }
    }

    println!("cargo:rerun-if-changed=thirdparty/");
    println!("cargo:rerun-if-changed=src/codegen/");
}