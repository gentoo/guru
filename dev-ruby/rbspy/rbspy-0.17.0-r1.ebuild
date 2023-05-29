# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.19.0
	adler-1.0.2
	ahash-0.8.3
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anyhow-1.0.69
	arrayvec-0.7.2
	atty-0.2.14
	autocfg-1.1.0
	bindgen-0.59.2
	bindgen-0.60.1
	bindgen-0.63.0
	bindgen-0.64.0
	bitflags-1.3.2
	bumpalo-3.12.0
	bytemuck-1.13.0
	byteorder-1.4.3
	bytes-1.4.0
	cc-1.0.79
	cexpr-0.6.0
	cfg-if-1.0.0
	chrono-0.4.24
	clang-sys-1.4.0
	clap-3.2.23
	clap_derive-3.2.18
	clap_lex-0.2.4
	codespan-reporting-0.11.1
	core-foundation-sys-0.8.3
	cpp_demangle-0.4.0
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-utils-0.8.14
	ctrlc-3.2.5
	cxx-1.0.89
	cxx-build-1.0.89
	cxxbridge-flags-1.0.89
	cxxbridge-macro-1.0.89
	dashmap-5.4.0
	directories-5.0.0
	dirs-sys-0.4.0
	either-1.8.1
	elf-0.0.12
	env_logger-0.9.3
	env_logger-0.10.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	fallible-iterator-0.2.0
	fastrand-1.9.0
	flate2-1.0.25
	getrandom-0.2.8
	gimli-0.27.1
	glob-0.3.1
	goblin-0.6.0
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.0
	humantime-2.1.0
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	indexmap-1.9.2
	inferno-0.11.14
	instant-0.1.12
	io-lifetimes-1.0.5
	is-terminal-0.4.3
	itertools-0.10.5
	itoa-1.0.5
	js-sys-0.3.61
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.139
	libloading-0.7.4
	libproc-0.12.0
	libproc-0.13.0
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	lock_api-0.4.9
	log-0.4.17
	mach-0.3.2
	mach2-0.4.1
	mach_o_sys-0.1.1
	memchr-2.5.0
	memmap-0.7.0
	memmap2-0.5.8
	memoffset-0.7.1
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	nix-0.25.1
	nix-0.26.2
	nom-7.1.3
	num-format-0.4.4
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.15.0
	object-0.30.3
	once_cell-1.17.0
	os_str_bytes-6.4.1
	parking_lot_core-0.9.7
	peeking_take_while-0.1.2
	pin-utils-0.1.0
	plain-0.2.3
	ppv-lite86-0.2.17
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.51
	proc-maps-0.3.0
	prost-0.11.6
	prost-derive-0.11.6
	quick-xml-0.26.0
	quote-1.0.23
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rbspy-testdata-0.1.9
	read-process-memory-0.1.5
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.1
	regex-syntax-0.6.28
	remoteprocess-0.4.11
	rgb-0.8.34
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	rustix-0.36.8
	ryu-1.0.12
	scopeguard-1.1.0
	scratch-1.0.3
	scroll-0.11.0
	scroll_derive-0.11.0
	semver-1.0.16
	serde-1.0.152
	serde_derive-1.0.152
	serde_json-1.0.92
	shlex-1.1.0
	smallvec-1.10.0
	spytools-0.1.4
	stable_deref_trait-1.2.0
	static_assertions-1.1.0
	str_stack-0.1.0
	strsim-0.10.0
	syn-1.0.107
	tempfile-3.4.0
	term_size-0.3.2
	termcolor-1.2.0
	textwrap-0.16.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	unicode-ident-1.0.6
	unicode-width-0.1.10
	version_check-0.9.4
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.84
	wasm-bindgen-backend-0.2.84
	wasm-bindgen-macro-0.2.84
	wasm-bindgen-macro-support-0.2.84
	wasm-bindgen-shared-0.2.84
	which-4.4.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows-sys-0.45.0
	windows-targets-0.42.1
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
"

inherit cargo

DESCRIPTION="Sampling CPU profiler for Ruby"
HOMEPAGE="https://rbspy.github.io https://github.com/rbspy/rbspy"
SRC_URI="
	https://github.com/rbspy/rbspy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 BSD-2 BSD CDDL ISC MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lang/ruby )"

QA_FLAGS_IGNORED="usr/bin/${PN}"

PATCHES=(
	"${FILESDIR}/${P}-remove-time-dependency.patch"
)

src_test() {
	local skip=(
		--skip sampler::tests::test_sample_single_process
		--skip sampler::tests::test_sample_single_process_with_time_limit
		--skip core::ruby_spy::tests::test_get_trace_when_process_has_exited
		--skip core::ruby_spy::tests::test_get_trace
		--skip sampler::tests::test_sample_subprocesses
	)
	cargo_src_test -- "${skip[@]}"
}

src_install() {
	cargo_src_install
	dodoc README.md
}
