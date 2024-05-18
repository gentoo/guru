# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.4
	anstyle@1.0.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anyhow@1.0.75
	arc-swap@1.6.0
	argfile@0.1.6
	async-broadcast@0.5.1
	async-channel@2.1.1
	async-executor@1.8.0
	async-fs@1.6.0
	async-io@1.13.0
	async-io@2.2.1
	async-lock@2.8.0
	async-lock@3.1.2
	async-priority-channel@0.1.0
	async-process@1.8.1
	async-recursion@1.0.5
	async-signal@0.2.5
	async-stream@0.3.5
	async-stream-impl@0.3.5
	async-task@4.5.0
	async-trait@0.1.74
	atomic-take@1.1.0
	atomic-waker@1.1.2
	autocfg@1.1.0
	axum@0.6.20
	axum-core@0.3.4
	backtrace@0.3.69
	backtrace-ext@0.2.1
	base64@0.21.5
	bitflags@1.3.2
	bitflags@2.4.1
	block@0.1.6
	block-buffer@0.10.4
	blocking@1.5.1
	boxcar@0.2.4
	bstr@1.8.0
	btoi@0.4.3
	bumpalo@3.14.0
	byteorder@1.5.0
	bytes@1.5.0
	c-gull@0.15.36
	c-scape@0.15.36
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	clap@4.4.8
	clap_builder@4.4.8
	clap_complete@4.4.4
	clap_complete_nushell@4.4.2
	clap_derive@4.4.7
	clap_lex@0.6.0
	clap_mangen@0.2.15
	clearscreen@2.0.1
	clru@0.6.1
	colorchoice@1.0.0
	command-group@5.0.1
	concurrent-queue@2.3.0
	console-api@0.6.0
	console-subscriber@0.2.0
	core-foundation-sys@0.8.4
	cpufeatures@0.2.11
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	cstr_core@0.2.6
	cty@0.2.2
	deranged@0.3.9
	derivative@2.2.0
	digest@0.10.7
	dirs@4.0.0
	dirs@5.0.1
	dirs-next@2.0.0
	dirs-sys@0.3.7
	dirs-sys@0.4.1
	dirs-sys-next@0.1.2
	dunce@1.0.4
	either@1.9.0
	embed-resource@2.4.0
	endian-type@0.1.2
	enumflags2@0.7.8
	enumflags2_derive@0.7.8
	env_logger@0.10.1
	equivalent@1.0.1
	errno@0.3.8
	event-listener@2.5.3
	event-listener@3.1.0
	event-listener@4.0.0
	event-listener-strategy@0.4.0
	eyra@0.16.8
	faster-hex@0.8.1
	fastrand@1.9.0
	fastrand@2.0.1
	filetime@0.2.22
	flate2@1.0.28
	fnv@1.0.7
	form_urlencoded@1.2.1
	fs-err@2.11.0
	fsevent-sys@4.1.0
	futures@0.3.29
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-lite@1.13.0
	futures-lite@2.0.1
	futures-macro@0.3.29
	futures-sink@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	generic-array@0.14.7
	getrandom@0.2.11
	gimli@0.28.1
	gix@0.55.2
	gix-actor@0.28.0
	gix-chunk@0.4.4
	gix-commitgraph@0.22.0
	gix-config@0.31.0
	gix-config-value@0.14.0
	gix-date@0.8.0
	gix-diff@0.37.0
	gix-discover@0.26.0
	gix-features@0.36.0
	gix-fs@0.8.0
	gix-glob@0.14.0
	gix-hash@0.13.1
	gix-hashtable@0.4.0
	gix-lock@11.0.0
	gix-macros@0.1.0
	gix-object@0.38.0
	gix-odb@0.54.0
	gix-pack@0.44.0
	gix-path@0.10.0
	gix-quote@0.4.7
	gix-ref@0.38.0
	gix-refspec@0.19.0
	gix-revision@0.23.0
	gix-revwalk@0.9.0
	gix-sec@0.10.0
	gix-tempfile@11.0.0
	gix-trace@0.1.3
	gix-traverse@0.34.0
	gix-url@0.25.1
	gix-utils@0.1.5
	gix-validate@0.8.0
	globset@0.4.13
	h2@0.3.22
	hashbrown@0.12.3
	hashbrown@0.14.2
	hdrhistogram@7.5.4
	heck@0.4.1
	hermit-abi@0.3.3
	hex@0.4.3
	home@0.5.5
	http@0.2.11
	http-body@0.4.5
	httparse@1.8.0
	httpdate@1.0.3
	humantime@2.1.0
	hyper@0.14.27
	hyper-timeout@0.4.1
	iana-time-zone@0.1.58
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	ignore@0.4.20
	indexmap@1.9.3
	indexmap@2.1.0
	inotify@0.9.6
	inotify-sys@0.1.5
	instant@0.1.12
	io-lifetimes@1.0.11
	is-terminal@0.4.9
	is_ci@1.1.1
	itertools@0.9.0
	itertools@0.11.0
	itoa@1.0.9
	js-sys@0.3.65
	kqueue@1.0.8
	kqueue-sys@1.0.4
	lazy_static@1.4.0
	libc@0.2.150
	libm@0.2.8
	libmimalloc-sys@0.1.35
	libredox@0.0.1
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.11
	lock_api@0.4.11
	log@0.4.20
	mac-notification-sys@0.6.1
	malloc_buf@0.0.6
	matchers@0.1.0
	matchit@0.7.3
	memchr@2.6.4
	memmap2@0.7.1
	memoffset@0.7.1
	memoffset@0.9.0
	miette@5.10.0
	miette-derive@5.10.0
	mimalloc@0.1.39
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.9
	nibble_vec@0.1.0
	nix@0.26.4
	nix@0.27.1
	nom@7.1.3
	normalize-line-endings@0.3.0
	normalize-path@0.2.1
	notify@6.1.1
	notify-rust@4.10.0
	nu-ansi-term@0.46.0
	num-complex@0.4.4
	num-traits@0.2.17
	num_cpus@1.16.0
	num_threads@0.1.6
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	object@0.32.1
	once_cell@1.18.0
	option-ext@0.2.0
	ordered-stream@0.2.0
	origin@0.16.4
	os_str_bytes@6.6.1
	overload@0.1.1
	owo-colors@3.5.0
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	percent-encoding@2.3.1
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pid1@0.1.1
	pin-project@1.1.3
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	piper@0.2.1
	polling@2.8.0
	polling@3.3.1
	posix-regex@0.1.1
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	printf-compat@0.1.1
	proc-macro-crate@1.3.1
	proc-macro2@1.0.69
	prodash@26.2.2
	prost@0.12.3
	prost-derive@0.12.3
	prost-types@0.12.3
	quick-xml@0.30.0
	quote@1.0.33
	radix_trie@0.2.1
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_pcg@0.3.1
	realpath-ext@0.1.3
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex@1.10.2
	regex-automata@0.1.10
	regex-automata@0.4.3
	regex-syntax@0.6.29
	regex-syntax@0.8.2
	roff@0.2.1
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.37.27
	rustix@0.38.28
	rustix-dlmalloc@0.1.1
	rustix-futex-sync@0.2.1
	rustix-openpty@0.1.1
	rustversion@1.0.14
	ryu@1.0.15
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.20
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	serde_repr@0.1.17
	serde_spanned@0.6.4
	sha1@0.10.6
	sha1_smol@1.0.0
	sharded-slab@0.1.7
	signal-hook@0.3.17
	signal-hook-registry@1.4.1
	similar@2.3.0
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.11.2
	smawk@0.3.2
	snapbox@0.4.14
	snapbox-macros@0.3.6
	socket2@0.4.10
	socket2@0.5.5
	static_assertions@1.1.0
	strsim@0.10.0
	supports-color@2.1.0
	supports-hyperlinks@2.1.0
	supports-unicode@2.0.0
	syn@1.0.109
	syn@2.0.39
	sync_wrapper@0.1.2
	tauri-winrt-notification@0.1.3
	tempfile@3.8.1
	termcolor@1.4.0
	terminal_size@0.1.17
	terminal_size@0.3.0
	terminfo@0.8.0
	textwrap@0.15.2
	thiserror@1.0.50
	thiserror-impl@1.0.50
	thread_local@1.1.7
	time@0.3.30
	time-core@0.1.2
	time-macros@0.2.15
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.34.0
	tokio-io-timeout@1.2.0
	tokio-macros@2.2.0
	tokio-stream@0.1.14
	tokio-util@0.7.10
	toml@0.8.8
	toml_datetime@0.6.5
	toml_edit@0.19.15
	toml_edit@0.21.0
	tonic@0.10.2
	tower@0.4.13
	tower-layer@0.3.2
	tower-service@0.3.2
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-serde@0.1.3
	tracing-subscriber@0.3.18
	try-lock@0.2.4
	typenum@1.17.0
	tz-rs@0.6.14
	uds_windows@1.0.2
	unicase@2.7.0
	unicode-bidi@0.3.13
	unicode-bom@2.0.3
	unicode-ident@1.0.12
	unicode-linebreak@0.1.5
	unicode-normalization@0.1.22
	unicode-width@0.1.11
	unwinding@0.2.1
	url@2.5.0
	utf8parse@0.2.1
	valuable@0.1.0
	version_check@0.9.4
	vswhom@0.1.0
	vswhom-sys@0.1.2
	waker-fn@1.1.1
	walkdir@2.4.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.88
	wasm-bindgen-backend@0.2.88
	wasm-bindgen-macro@0.2.88
	wasm-bindgen-macro-support@0.2.88
	wasm-bindgen-shared@0.2.88
	which@4.4.2
	which@5.0.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.48.0
	windows@0.51.1
	windows-core@0.51.1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winnow@0.5.19
	winreg@0.51.0
	xdg-home@1.0.0
	zbus@3.14.1
	zbus_macros@3.14.1
	zbus_names@2.6.0
	zvariant@3.15.0
	zvariant_derive@3.15.0
	zvariant_utils@1.0.1
"

inherit cargo shell-completion

DESCRIPTION="Executes commands in response to file modifications"
HOMEPAGE="https://watchexec.github.io/"
SRC_URI="https://github.com/watchexec/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Prevent portage from trying to fetch bunch of *.crate from mirror despite they are not mirrored.
RESTRICT="mirror"

DOCS=( crates/cli/README.md )

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	cargo_src_compile --manifest-path=crates/cli/Cargo.toml
}

src_test() {
	cargo_src_test --manifest-path crates/lib/Cargo.toml --lib
	cargo_src_test --manifest-path crates/cli/Cargo.toml
}

src_install() {
	cargo_src_install --path "${S}"/crates/cli

	einstalldocs
	doman doc/watchexec.1

	newbashcomp completions/bash "${PN}"

	newzshcomp completions/zsh "_${PN}"

	newfishcomp completions/fish "${PN}.fish"
}
