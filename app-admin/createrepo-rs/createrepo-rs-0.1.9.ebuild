# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2-2.0.1
	ahash-0.8.12
	anstream-1.0.0
	anstyle-1.0.14
	anstyle-parse-1.0.0
	anstyle-query-1.1.5
	anstyle-wincon-3.0.11
	autocfg-1.5.0
	bitflags-2.11.1
	block-buffer-0.10.4
	block2-0.6.2
	bzip2-0.4.4
	bzip2-sys-0.1.13+1.0.8
	cc-1.2.60
	cfg-if-1.0.4
	cfg_aliases-0.2.1
	clap-4.6.1
	clap_builder-4.6.0
	clap_derive-4.6.1
	clap_lex-1.1.0
	colorchoice-1.0.5
	cpio-0.2.2
	cpufeatures-0.2.17
	crc32fast-1.5.0
	crossbeam-channel-0.5.15
	crossbeam-utils-0.8.21
	crypto-common-0.1.7
	ctrlc-3.5.2
	digest-0.10.7
	dispatch2-0.3.1
	either-1.15.0
	enum-display-derive-0.1.1
	enum-primitive-derive-0.3.0
	fallible-iterator-0.3.0
	fallible-streaming-iterator-0.1.9
	find-msvc-tools-0.1.9
	flate2-1.1.9
	generic-array-0.14.7
	getrandom-0.3.4
	glob-0.3.3
	hashbrown-0.14.5
	hashlink-0.9.1
	heck-0.5.0
	hermit-abi-0.5.2
	hex-0.4.3
	is_terminal_polyfill-1.70.2
	itertools-0.12.1
	jobserver-0.1.34
	libc-0.2.185
	libsqlite3-sys-0.30.1
	log-0.4.29
	lzma-sys-0.1.20
	md-5-0.10.6
	memchr-2.8.0
	minimal-lexical-0.2.1
	miniz_oxide-0.8.9
	nix-0.31.2
	nom-7.1.3
	num-0.4.3
	num-bigint-0.4.6
	num-complex-0.4.6
	num-derive-0.4.2
	num-integer-0.1.46
	num-iter-0.1.45
	num-rational-0.4.2
	num-traits-0.2.19
	num_cpus-1.17.0
	objc2-0.6.4
	objc2-encode-4.1.0
	once_cell-1.21.4
	once_cell_polyfill-1.70.2
	pkg-config-0.3.33
	proc-macro2-1.0.106
	quick-xml-0.37.5
	quote-1.0.45
	r-efi-5.3.0
	rpm-0.14.0
	rusqlite-0.32.1
	same-file-1.0.6
	sha1-0.10.6
	sha2-0.10.9
	shlex-1.3.0
	simd-adler32-0.3.9
	smallvec-1.15.1
	strsim-0.11.1
	syn-1.0.109
	syn-2.0.117
	thiserror-1.0.69
	thiserror-impl-1.0.69
	typenum-1.20.0
	unicode-ident-1.0.24
	utf8parse-0.2.2
	vcpkg-0.2.15
	version_check-0.9.5
	walkdir-2.5.0
	wasip2-1.0.3+wasi-0.2.9
	winapi-util-0.1.11
	windows-link-0.2.1
	windows-sys-0.61.2
	wit-bindgen-0.57.1
	xz2-0.1.7
	zerocopy-0.8.48
	zerocopy-derive-0.8.48
	zstd-0.13.3
	zstd-safe-7.2.4
	zstd-sys-2.0.16+zstd.1.5.7
"

inherit cargo

DESCRIPTION="Pure Rust RPM repository metadata generator — dnf/yum-compatible, zero FFI"
HOMEPAGE="https://github.com/jamesarch/createrepo_rs"
SRC_URI="
	https://github.com/jamesarch/createrepo_rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="GPL-2+"
# crate licenses
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# bzip2-sys and lzma-sys link to system libraries; zstd and sqlite are bundled
RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/createrepo_rs-${PV}"

src_unpack() {
	default
	cargo_gen_config
}

src_compile() {
	cargo_src_compile
}

src_test() {
	cargo_src_test
}

src_install() {
	dobin "target/release/createrepo_rs"
	dodoc README.md README_zh.md LICENSE
}
