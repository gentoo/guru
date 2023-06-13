# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.19.0
	adler-1.0.2
	aho-corasick-1.0.2
	android-tzdata-0.1.1
	android_system_properties-0.1.5
	anstream-0.3.2
	anstyle-1.0.0
	anstyle-parse-0.2.0
	anstyle-query-1.0.0
	anstyle-wincon-1.0.1
	anyhow-1.0.71
	assert_cmd-2.0.11
	async-trait-0.1.68
	autocfg-1.1.0
	backtrace-0.3.67
	base64-0.13.1
	base64-0.21.2
	better-panic-0.3.0
	bindgen-0.64.0
	bitflags-1.3.2
	block-buffer-0.10.4
	bstr-0.2.17
	bstr-1.5.0
	bumpalo-3.13.0
	byteorder-1.4.3
	bytes-1.4.0
	cc-1.0.79
	cexpr-0.6.0
	cfg-if-1.0.0
	chrono-0.4.26
	chrono-english-0.1.7
	clang-sys-1.6.1
	clap-4.3.3
	clap_builder-4.3.3
	clap_complete-4.3.1
	clap_derive-4.3.2
	clap_lex-0.5.0
	colorchoice-1.0.0
	comfy-table-7.0.0
	command-group-2.1.0
	console-0.15.7
	core-foundation-sys-0.8.4
	cpufeatures-0.2.7
	crossterm-0.26.1
	crossterm_winapi-0.9.0
	crypto-common-0.1.6
	ctor-0.1.26
	ctrlc-3.4.0
	diff-0.1.13
	difflib-0.4.0
	digest-0.10.7
	dirs-5.0.1
	dirs-sys-0.4.1
	doc-comment-0.3.3
	either-1.8.1
	encode_unicode-0.3.6
	env_logger-0.10.0
	errno-0.2.8
	errno-0.3.1
	errno-dragonfly-0.1.2
	fastrand-1.9.0
	futures-0.3.28
	futures-channel-0.3.28
	futures-core-0.3.28
	futures-executor-0.3.28
	futures-io-0.3.28
	futures-macro-0.3.28
	futures-sink-0.3.28
	futures-task-0.3.28
	futures-timer-3.0.2
	futures-util-0.3.28
	generic-array-0.14.7
	getrandom-0.2.10
	gimli-0.27.2
	glob-0.3.1
	half-1.8.2
	handlebars-4.3.7
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	hex-0.4.3
	humantime-2.1.0
	iana-time-zone-0.1.57
	iana-time-zone-haiku-0.1.2
	indexmap-1.9.3
	instant-0.1.12
	io-lifetimes-1.0.11
	is-terminal-0.4.7
	itertools-0.10.5
	itoa-1.0.6
	js-sys-0.3.63
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.146
	libloading-0.7.4
	libproc-0.13.0
	linux-raw-sys-0.1.4
	linux-raw-sys-0.3.8
	lock_api-0.4.10
	log-0.4.19
	memchr-2.5.0
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	mio-0.8.8
	nix-0.26.2
	nom-7.1.3
	num-traits-0.2.15
	num_cpus-1.15.0
	num_threads-0.1.6
	object-0.30.4
	once_cell-1.18.0
	option-ext-0.2.0
	output_vt100-0.1.3
	parking_lot-0.12.1
	parking_lot_core-0.9.8
	peeking_take_while-0.1.2
	pem-1.1.1
	pest-2.6.0
	pest_derive-2.6.0
	pest_generator-2.6.0
	pest_meta-2.6.0
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	portpicker-0.1.1
	ppv-lite86-0.2.17
	predicates-3.0.3
	predicates-core-1.0.6
	predicates-tree-1.0.9
	pretty_assertions-1.3.0
	proc-macro2-1.0.60
	procfs-0.15.1
	quote-1.0.28
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rcgen-0.10.0
	redox_syscall-0.2.16
	redox_syscall-0.3.5
	redox_users-0.4.3
	regex-1.8.4
	regex-automata-0.1.10
	regex-syntax-0.7.2
	rev_buf_reader-0.3.0
	ring-0.16.20
	rstest-0.17.0
	rstest_macros-0.17.0
	rustc-demangle-0.1.23
	rustc-hash-1.1.0
	rustc_version-0.4.0
	rustix-0.36.14
	rustix-0.37.20
	rustls-0.21.1
	rustls-pemfile-1.0.2
	rustls-webpki-0.100.1
	rustversion-1.0.12
	ryu-1.0.13
	scanlex-0.1.4
	scopeguard-1.1.0
	sct-0.7.0
	semver-1.0.17
	serde-1.0.164
	serde_cbor-0.11.2
	serde_derive-1.0.164
	serde_json-1.0.96
	serde_yaml-0.9.21
	sha2-0.10.6
	shell-escape-0.1.5
	shellexpand-3.1.0
	shlex-1.1.0
	signal-hook-0.3.15
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.1
	similar-2.2.1
	similar-asserts-1.4.2
	simplelog-0.12.1
	slab-0.4.8
	smallvec-1.10.0
	snap-1.1.0
	socket2-0.4.9
	spin-0.5.2
	static_assertions-1.1.0
	strsim-0.10.0
	strum-0.24.1
	strum_macros-0.24.3
	syn-1.0.109
	syn-2.0.18
	tempfile-3.6.0
	termcolor-1.1.3
	termtree-0.4.1
	test-log-0.2.11
	thiserror-1.0.40
	thiserror-impl-1.0.40
	time-0.1.45
	time-0.3.22
	time-core-0.1.1
	time-macros-0.2.9
	tokio-1.28.2
	tokio-macros-2.1.0
	tokio-rustls-0.24.1
	typenum-1.16.0
	ucd-trie-0.1.5
	unicode-ident-1.0.9
	unicode-segmentation-1.10.1
	unicode-width-0.1.10
	unsafe-libyaml-0.2.8
	untrusted-0.7.1
	utf8parse-0.2.1
	version_check-0.9.4
	wait-timeout-0.2.0
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.86
	wasm-bindgen-backend-0.2.86
	wasm-bindgen-macro-0.2.86
	wasm-bindgen-macro-support-0.2.86
	wasm-bindgen-shared-0.2.86
	web-sys-0.3.63
	whoami-1.4.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.48.0
	windows-sys-0.45.0
	windows-sys-0.48.0
	windows-targets-0.42.2
	windows-targets-0.48.0
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_gnullvm-0.48.0
	windows_aarch64_msvc-0.42.2
	windows_aarch64_msvc-0.48.0
	windows_i686_gnu-0.42.2
	windows_i686_gnu-0.48.0
	windows_i686_msvc-0.42.2
	windows_i686_msvc-0.48.0
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnu-0.48.0
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_gnullvm-0.48.0
	windows_x86_64_msvc-0.42.2
	windows_x86_64_msvc-0.48.0
	yansi-0.5.1
	yasna-0.5.2
"

inherit cargo systemd shell-completion

DESCRIPTION="A cli tool for managing long running shell commands."
HOMEPAGE="https://github.com/nukesor/pueue"

SRC_URI="
	$(cargo_crate_uris)
	https://github.com/Nukesor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="
	usr/bin/${PN}
	usr/bin/${PN}d
	"

src_install() {
	cargo_src_install --path pueue

	# generate and install shell completions files
	mkdir completions

	# bash completions
	"${ED}"/usr/bin/pueue completions bash completions || die "gen bash completion failed"
	newbashcomp completions/${PN}.bash ${PN}

	# zsh completions
	"${ED}"/usr/bin/pueue completions zsh completions || die "gen zsh completion failed"
	dozshcomp completions/_${PN}

	# fish completions
	"${ED}"/usr/bin/pueue completions fish completions || die "gen fish completion failed "
	dofishcomp completions/${PN}.fish

	# install the systemd-service
	systemd_douserunit utils/pueued.service
}
