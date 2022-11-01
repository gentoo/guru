# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.56
	arc-swap-0.4.8
	arrayvec-0.5.2
	async-channel-1.6.1
	async-executor-1.4.1
	async-global-executor-2.0.3
	async-io-1.6.0
	async-lock-2.5.0
	async-mutex-1.4.0
	async-process-1.3.0
	async-std-1.10.0
	async-task-4.2.0
	async-trait-0.1.52
	atomic-waker-1.0.0
	atty-0.2.14
	autocfg-1.1.0
	backtrace-0.3.64
	base64-0.13.0
	bincode-1.3.3
	bitflags-1.3.2
	block-buffer-0.7.3
	block-buffer-0.9.0
	block-padding-0.1.5
	blocking-1.2.0
	boxfnonce-0.1.1
	bumpalo-3.9.1
	byte-tools-0.3.1
	byteorder-1.4.3
	cache-padded-1.2.0
	cassowary-0.3.0
	cc-1.0.73
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	clap-3.1.6
	clap_complete-3.1.1
	clap_derive-3.1.4
	close_fds-0.3.2
	colored-2.0.0
	colorsys-0.6.5
	concurrent-queue-1.2.2
	console-0.15.0
	core-foundation-sys-0.8.3
	cpufeatures-0.2.1
	cranelift-bforest-0.68.0
	cranelift-codegen-0.68.0
	cranelift-codegen-meta-0.68.0
	cranelift-codegen-shared-0.68.0
	cranelift-entity-0.68.0
	cranelift-frontend-0.68.0
	crc32fast-1.3.2
	crossbeam-0.8.1
	crossbeam-channel-0.5.4
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.8
	crossbeam-queue-0.3.5
	crossbeam-utils-0.8.8
	csscolorparser-0.5.0
	ctor-0.1.22
	daemonize-0.4.1
	darling-0.13.1
	darling_core-0.13.1
	darling_macro-0.13.1
	derivative-2.2.0
	dialoguer-0.9.0
	digest-0.8.1
	digest-0.9.0
	directories-next-2.0.0
	dirs-2.0.2
	dirs-sys-0.3.7
	dirs-sys-next-0.1.2
	either-1.6.1
	encode_unicode-0.3.6
	enumset-1.0.8
	enumset_derive-0.5.5
	erased-serde-0.3.20
	event-listener-2.5.2
	fake-simd-0.1.2
	fallible-iterator-0.2.0
	fastrand-1.7.0
	filedescriptor-0.8.2
	fnv-1.0.7
	form_urlencoded-1.0.1
	fuchsia-cprng-0.1.1
	futures-0.3.21
	futures-channel-0.3.21
	futures-core-0.3.21
	futures-executor-0.3.21
	futures-io-0.3.21
	futures-lite-1.12.0
	futures-macro-0.3.21
	futures-sink-0.3.21
	futures-task-0.3.21
	futures-util-0.3.21
	generational-arena-0.2.8
	generic-array-0.12.4
	generic-array-0.14.5
	getopts-0.2.21
	getrandom-0.1.16
	getrandom-0.2.5
	ghost-0.1.2
	gimli-0.22.0
	gimli-0.26.1
	gloo-timers-0.2.3
	hashbrown-0.11.2
	heck-0.3.3
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	highway-0.6.4
	humantime-2.1.0
	ident_case-1.0.1
	idna-0.2.3
	indexmap-1.8.0
	insta-1.13.0
	instant-0.1.12
	interprocess-1.1.1
	intmap-0.7.1
	inventory-0.2.2
	is_ci-1.1.1
	itoa-1.0.1
	js-sys-0.3.56
	kv-log-macro-1.0.7
	lazy_static-1.4.0
	leb128-0.2.5
	lev_distance-0.1.1
	libc-0.2.121
	libloading-0.6.7
	libssh2-sys-0.2.23
	libz-sys-1.1.5
	linked-hash-map-0.5.4
	lock_api-0.4.6
	log-0.4.16
	log-mdc-0.1.0
	log4rs-1.0.0
	mach-0.3.2
	maplit-1.0.2
	matches-0.1.9
	memchr-2.4.1
	memmap2-0.2.3
	memmem-0.1.1
	memoffset-0.6.5
	miette-3.3.0
	miette-derive-3.3.0
	miniz_oxide-0.4.4
	mio-0.7.14
	miow-0.3.7
	more-asserts-0.2.2
	names-0.11.0
	nix-0.23.1
	nom-5.1.2
	ntapi-0.3.7
	num-derive-0.3.3
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.1
	object-0.22.0
	object-0.27.1
	once_cell-1.10.0
	opaque-debug-0.2.3
	opaque-debug-0.3.0
	openssl-sys-0.9.72
	ordered-float-2.10.0
	os_str_bytes-6.0.0
	owo-colors-3.3.0
	parking-2.0.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	phf-0.8.0
	phf_codegen-0.8.0
	phf_generator-0.8.0
	phf_macros-0.8.0
	phf_shared-0.8.0
	pin-project-lite-0.2.8
	pin-utils-0.1.0
	pkg-config-0.3.24
	polling-2.2.0
	ppv-lite86-0.2.16
	pretty-bytes-0.2.2
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro2-1.0.36
	quote-1.0.16
	rand-0.3.23
	rand-0.4.6
	rand-0.7.3
	rand-0.8.5
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.3.1
	rand_core-0.4.2
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_pcg-0.2.1
	rayon-1.5.1
	rayon-core-1.9.1
	rdrand-0.4.0
	redox_syscall-0.1.57
	redox_syscall-0.2.11
	redox_users-0.4.2
	regalloc-0.0.31
	regex-1.5.5
	regex-syntax-0.6.25
	region-2.2.0
	remove_dir_all-0.5.3
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	ryu-1.0.9
	scopeguard-1.1.0
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.136
	serde-value-0.7.0
	serde_bytes-0.11.5
	serde_derive-1.0.136
	serde_json-1.0.79
	serde_yaml-0.8.23
	sha-1-0.8.2
	sha2-0.9.9
	signal-hook-0.1.17
	signal-hook-0.3.13
	signal-hook-registry-1.4.0
	similar-2.1.0
	siphasher-0.3.10
	slab-0.4.5
	smallvec-1.8.0
	smawk-0.3.1
	socket2-0.4.4
	spinning-0.1.0
	ssh2-0.9.3
	stable_deref_trait-1.2.0
	strip-ansi-escapes-0.1.1
	strsim-0.10.0
	strum-0.20.0
	strum_macros-0.20.1
	suggestion-0.3.3
	supports-color-1.3.0
	supports-hyperlinks-1.2.0
	supports-unicode-1.0.2
	syn-1.0.89
	sysinfo-0.22.5
	target-lexicon-0.11.2
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.1.17
	terminfo-0.7.3
	termios-0.3.3
	termwiz-0.16.0
	textwrap-0.14.2
	textwrap-0.15.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	thread-id-3.3.0
	time-0.1.44
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	tracing-0.1.32
	tracing-attributes-0.1.20
	tracing-core-0.1.23
	traitobject-0.1.0
	typemap-0.3.3
	typenum-1.15.0
	typetag-0.1.8
	typetag-impl-0.1.8
	ucd-trie-0.1.3
	unicode-bidi-0.3.7
	unicode-linebreak-0.1.2
	unicode-normalization-0.1.19
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	unsafe-any-0.4.2
	url-2.2.2
	utf8parse-0.2.0
	value-bag-1.0.0-alpha.8
	vcpkg-0.2.15
	version_check-0.9.4
	vte-0.10.1
	vte_generate_state_changes-0.1.1
	vtparse-0.6.1
	waker-fn-1.1.0
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.79
	wasm-bindgen-backend-0.2.79
	wasm-bindgen-futures-0.4.29
	wasm-bindgen-macro-0.2.79
	wasm-bindgen-macro-support-0.2.79
	wasm-bindgen-shared-0.2.79
	wasmer-1.0.2
	wasmer-compiler-1.0.2
	wasmer-compiler-cranelift-1.0.2
	wasmer-derive-1.0.2
	wasmer-engine-1.0.2
	wasmer-engine-jit-1.0.2
	wasmer-engine-native-1.0.2
	wasmer-object-1.0.2
	wasmer-types-1.0.2
	wasmer-vm-1.0.2
	wasmer-wasi-1.0.2
	wasmparser-0.65.0
	wast-39.0.0
	wat-1.0.41
	web-sys-0.3.56
	wepoll-ffi-0.1.2
	wezterm-bidi-0.1.0
	wezterm-color-types-0.1.0
	which-4.2.5
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	yaml-rust-0.4.5
	zeroize-1.5.4
"

inherit bash-completion-r1 cargo xdg desktop

DESCRIPTION="A terminal workspace with batteries included"
HOMEPAGE="
	https://zellij.dev
	https://github.com/zellij-org/zellij
"
SRC_URI="
	https://github.com/zellij-org/zellij/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"
LICENSE="
	|| ( 0BSD Apache-2.0 MIT )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD-2 MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( Apache-2.0-with-LLVM-exceptions MIT )
	|| ( MIT Unlicense )
	Apache-2.0
	Apache-2.0-with-LLVM-exceptions
	BSD
	BSD-2
	CC0-1.0
	ISC
	MIT
	MPL-2.0
	WTFPL-2
"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-text/mandown
"
#	dev-util/binaryen
#	dev-util/cargo-make
#"

QA_FLAGS_IGNORED="usr/bin/zellij"

src_configure() {
	local myfeatures=(
		disable_automatic_asset_installation
	)
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
#	cargo make build-release || die
#	cargo make manpage || die
#	cargo make wasm-opt-plugins || die
	mkdir -p assets/man || die
	mandown docs/MANPAGE.md ZELLIJ 1 > assets/man/zellij.1 || die
	mkdir -p assets/completions || die
	./target/release/zellij setup --generate-completion bash > assets/completions/zellij.bash || die
	./target/release/zellij setup --generate-completion fish > assets/completions/zellij.fish || die
	./target/release/zellij setup --generate-completion zsh > assets/completions/_zellij || die
}

src_install() {
	cargo_src_install

	insinto /usr/share/zellij/layouts/
	doins -r example/layouts/*

	insinto /usr/share/zellij/plugins/
	doins -r assets/plugins/*

	doman assets/man/zellij.1

#	insinto /usr/share/xsessions/
	domenu assets/zellij.desktop

	dodoc README.md CHANGELOG.md docs/*.md

	newbashcomp assets/completions/zellij.bash zellij
	insinto /usr/share/fish/vendor_completions.d
	doins assets/completions/zellij.fish
	insinto /usr/share/zsh/site-functions
	doins assets/completions/_zellij
}
