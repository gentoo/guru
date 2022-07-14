# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	ahash-0.7.6
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.55
	arrayvec-0.4.12
	atty-0.2.14
	autocfg-1.1.0
	bindgen-0.59.2
	bitflags-1.3.2
	bytemuck-1.7.3
	byteorder-0.5.3
	byteorder-1.4.3
	bytes-1.1.0
	cc-1.0.73
	cexpr-0.6.0
	cfg-if-1.0.0
	chrono-0.4.19
	clang-sys-1.3.1
	clap-2.34.0
	clap-3.1.6
	clap_derive-3.1.4
	cpp_demangle-0.3.5
	crc32fast-1.3.2
	crossbeam-channel-0.5.2
	crossbeam-utils-0.8.7
	ctrlc-3.2.1
	dashmap-5.1.0
	directories-4.0.1
	dirs-sys-0.3.7
	either-1.6.1
	elf-0.0.10
	env_logger-0.9.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	fallible-iterator-0.2.0
	flate2-1.0.22
	fuchsia-cprng-0.1.1
	getrandom-0.2.5
	gimli-0.26.1
	glob-0.3.0
	goblin-0.4.3
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.19
	humantime-2.1.0
	indexmap-1.8.0
	inferno-0.11.1
	itertools-0.10.3
	itoa-0.4.8
	itoa-1.0.1
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.119
	libloading-0.7.3
	libproc-0.10.0
	lock_api-0.4.6
	log-0.4.14
	mach-0.3.2
	mach_o_sys-0.1.1
	memchr-2.4.1
	memmap-0.7.0
	memoffset-0.6.5
	minimal-lexical-0.2.1
	miniz_oxide-0.4.4
	nix-0.23.1
	nodrop-0.1.14
	nom-7.1.0
	num-format-0.4.0
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.1
	object-0.27.1
	once_cell-1.9.0
	os_str_bytes-6.0.0
	parking_lot-0.12.0
	parking_lot_core-0.9.1
	peeking_take_while-0.1.2
	plain-0.2.3
	ppv-lite86-0.2.16
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	proc-maps-0.2.0
	prost-0.10.0
	prost-derive-0.10.0
	quick-xml-0.22.0
	quote-1.0.15
	rand-0.4.6
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.3.1
	rand_core-0.4.2
	rand_core-0.6.3
	rbspy-testdata-0.1.5
	rdrand-0.4.0
	read-process-memory-0.1.4
	redox_syscall-0.2.12
	redox_users-0.4.2
	regex-1.5.4
	regex-syntax-0.6.25
	remoteprocess-0.4.8
	remove_dir_all-0.5.3
	rgb-0.8.31
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	ryu-1.0.9
	scopeguard-1.1.0
	scroll-0.10.2
	scroll_derive-0.10.5
	serde-1.0.136
	serde_derive-1.0.136
	serde_json-1.0.79
	shlex-1.1.0
	smallvec-1.8.0
	stable_deref_trait-1.2.0
	str_stack-0.1.0
	strsim-0.8.0
	strsim-0.10.0
	syn-1.0.86
	tempdir-0.3.7
	term_size-0.3.2
	termcolor-1.1.2
	textwrap-0.11.0
	textwrap-0.15.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	time-0.1.44
	unicode-width-0.1.9
	unicode-xid-0.2.2
	vec_map-0.8.2
	version_check-0.9.4
	wasi-0.10.0+wasi-snapshot-preview1
	which-4.2.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.32.0
	windows_aarch64_msvc-0.32.0
	windows_i686_gnu-0.32.0
	windows_i686_msvc-0.32.0
	windows_x86_64_gnu-0.32.0
	windows_x86_64_msvc-0.32.0
"

inherit cargo

DESCRIPTION="Sampling CPU profiler for Ruby"
HOMEPAGE="https://rbspy.github.io https://github.com/rbspy/rbspy"
SRC_URI="
	https://github.com/rbspy/rbspy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 BSD-2 BSD CDDL ISC MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lang/ruby )"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install

	dodoc README.md
}
