# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	ahash-0.7.6
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.51
	arrayvec-0.4.12
	atty-0.2.14
	autocfg-1.0.1
	bindgen-0.59.2
	bitflags-1.3.2
	bytemuck-1.7.2
	byteorder-0.5.3
	byteorder-1.4.3
	bytes-1.1.0
	cc-1.0.72
	cexpr-0.6.0
	cfg-if-1.0.0
	chrono-0.4.19
	clang-sys-1.3.0
	clap-2.34.0
	cpp_demangle-0.3.5
	crc32fast-1.3.0
	crossbeam-channel-0.5.1
	crossbeam-utils-0.8.5
	ctrlc-3.2.1
	dashmap-4.0.2
	either-1.6.1
	elf-0.0.10
	env_logger-0.9.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	fallible-iterator-0.2.0
	flate2-1.0.22
	fuchsia-cprng-0.1.1
	getrandom-0.2.3
	gimli-0.26.1
	glob-0.3.0
	goblin-0.4.3
	hashbrown-0.11.2
	heck-0.3.3
	hermit-abi-0.1.19
	humantime-2.1.0
	indexmap-1.7.0
	inferno-0.10.8
	itertools-0.10.3
	itoa-0.4.8
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.111
	libloading-0.7.2
	libproc-0.10.0
	log-0.4.14
	mach-0.0.5
	mach-0.3.2
	mach_o_sys-0.1.1
	memchr-2.4.1
	memmap-0.7.0
	memoffset-0.6.5
	minimal-lexical-0.2.1
	miniz_oxide-0.4.4
	nix-0.23.0
	nodrop-0.1.14
	nom-7.1.0
	num-format-0.4.0
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	object-0.27.1
	once_cell-1.8.0
	peeking_take_while-0.1.2
	plain-0.2.3
	ppv-lite86-0.2.15
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.33
	proc-maps-0.2.0
	prost-0.9.0
	prost-derive-0.9.0
	quick-xml-0.22.0
	quote-1.0.10
	rand-0.4.6
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.3.1
	rand_core-0.4.2
	rand_core-0.6.3
	rand_hc-0.3.1
	rbspy-testdata-0.1.5
	rdrand-0.4.0
	read-process-memory-0.1.3
	regex-1.5.4
	regex-syntax-0.6.25
	remoteprocess-0.4.7
	remove_dir_all-0.5.3
	rgb-0.8.30
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	rustc_version-0.4.0
	ryu-1.0.7
	scroll-0.10.2
	scroll_derive-0.10.5
	semver-1.0.4
	serde-1.0.131
	serde_derive-1.0.131
	serde_json-1.0.72
	shlex-1.1.0
	smallvec-1.7.0
	stable_deref_trait-1.2.0
	str_stack-0.1.0
	strsim-0.8.0
	structopt-0.3.25
	structopt-derive-0.4.18
	syn-1.0.82
	tempdir-0.3.7
	term_size-0.3.2
	termcolor-1.1.2
	textwrap-0.11.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	time-0.1.43
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	vec_map-0.8.2
	version_check-0.9.3
	wasi-0.10.2+wasi-snapshot-preview1
	which-4.2.2
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	"
inherit cargo

DESCRIPTION="Sampling profiler for Ruby"
HOMEPAGE="https://rbspy.github.io https://github.com/rbspy/rbspy"
SRC_URI="
	https://github.com/rbspy/rbspy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
	"

QA_FLAGS_IGNORED="usr/bin/${PN}"

LICENSE="Apache-2.0 BSD-2 BSD CDDL ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lang/ruby )"
