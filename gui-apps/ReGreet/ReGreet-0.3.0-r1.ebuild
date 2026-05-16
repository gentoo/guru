# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.87.0"

MY_PN="ReGreet"
MY_P="${MY_PN}-${PV}"

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.6
	anstyle@1.0.10
	anyhow@1.0.102
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-executor@1.14.0
	async-fs@2.2.0
	async-io@2.6.0
	async-lock@3.4.0
	async-process@2.5.0
	async-recursion@1.1.1
	async-signal@0.2.14
	async-task@4.7.1
	async-trait@0.1.83
	atomic-waker@1.1.2
	autocfg@1.4.0
	backtrace@0.3.74
	bitflags@2.6.0
	block-buffer@0.10.4
	blocking@1.6.2
	bumpalo@3.16.0
	bytes@1.11.1
	cairo-rs@0.20.7
	cairo-sys-rs@0.20.7
	cc@1.2.6
	cfg-expr@0.17.2
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.39
	clap@4.5.23
	clap_builder@4.5.23
	clap_derive@4.5.18
	clap_lex@0.7.4
	colorchoice@1.0.3
	concurrent-queue@2.5.0
	const_format@0.2.34
	const_format_proc_macros@0.2.34
	core-foundation-sys@0.8.7
	cpufeatures@0.2.17
	crc32fast@1.4.2
	crossbeam-channel@0.5.15
	crossbeam-utils@0.8.21
	crypto-common@0.1.7
	deranged@0.4.0
	digest@0.10.7
	educe@0.6.0
	endi@1.1.1
	enum-ordinalize-derive@4.3.1
	enum-ordinalize@4.3.0
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.1
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	fastrand@2.4.1
	field-offset@0.3.6
	file-rotate@0.7.6
	flate2@1.0.35
	flume@0.11.1
	foldhash@0.1.5
	foldhash@0.2.0
	fragile@2.0.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.6.1
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	gdk-pixbuf-sys@0.20.7
	gdk-pixbuf@0.20.7
	gdk4-sys@0.9.5
	gdk4@0.9.5
	generic-array@0.14.7
	getrandom@0.2.15
	getrandom@0.4.2
	gimli@0.31.1
	gio-sys@0.20.8
	gio@0.20.7
	glib-macros@0.20.7
	glib-sys@0.20.7
	glib@0.20.7
	glob@0.3.2
	gobject-sys@0.20.7
	graphene-rs@0.20.7
	graphene-sys@0.20.7
	greetd_ipc@0.10.3
	gsk4-sys@0.9.5
	gsk4@0.9.5
	gtk4-macros@0.9.5
	gtk4-sys@0.9.5
	gtk4@0.9.5
	hashbrown@0.15.2
	hashbrown@0.16.1
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	humantime-serde@1.1.1
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	id-arena@2.3.0
	indexmap@2.7.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.14
	jiff-tzdb-platform@0.1.1
	jiff-tzdb@0.1.1
	jiff@0.1.16
	js-sys@0.3.76
	konst@0.2.19
	konst_macro_rules@0.2.19
	lazy_static@1.5.0
	leb128fmt@0.1.0
	libc@0.2.184
	linux-raw-sys@0.12.1
	lock_api@0.4.12
	log@0.4.22
	lru@0.16.3
	memchr@2.7.4
	memoffset@0.9.1
	miniz_oxide@0.8.2
	mio@1.0.3
	nanorand@0.7.0
	nix@0.29.0
	nu-ansi-term@0.50.1
	num-conv@0.1.0
	num-traits@0.2.19
	num_threads@0.1.7
	object@0.36.7
	once_cell@1.20.2
	ordered-stream@0.2.0
	pango-sys@0.20.7
	pango@0.20.7
	parking@2.2.1
	pin-project-lite@0.2.15
	pin-utils@0.1.0
	piper@0.2.5
	pkg-config@0.3.31
	polling@3.11.0
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	prettyplease@0.2.25
	proc-macro-crate@3.2.0
	proc-macro2@1.0.92
	quote@1.0.38
	r-efi@6.0.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	relm4-css@0.9.0
	relm4-macros@0.9.1
	relm4@0.9.1
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	rustix@1.1.4
	ryu@1.0.18
	scopeguard@1.2.0
	semver@1.0.24
	serde@1.0.217
	serde_derive@1.0.217
	serde_json@1.0.134
	serde_repr@0.1.20
	serde_spanned@0.6.8
	sha1@0.10.6
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.8
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.8
	spin@0.9.8
	static_assertions@1.1.0
	strsim@0.11.1
	syn@2.0.93
	system-deps@7.0.3
	target-lexicon@0.12.16
	tempfile@3.27.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.9
	thiserror@1.0.69
	thiserror@2.0.9
	thread_local@1.1.8
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	tokio@1.43.1
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tracing-appender@0.2.3
	tracing-attributes@0.1.28
	tracing-core@0.1.33
	tracing-log@0.2.0
	tracing-subscriber@0.3.20
	tracing@0.1.41
	tracker-macros@0.2.2
	tracker@0.2.2
	typenum@1.19.0
	uds_windows@1.2.1
	unicode-ident@1.0.14
	unicode-xid@0.2.6
	utf8parse@0.2.2
	valuable@0.1.0
	version-compare@0.2.0
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-backend@0.2.99
	wasm-bindgen-macro-support@0.2.99
	wasm-bindgen-macro@0.2.99
	wasm-bindgen-shared@0.2.99
	wasm-bindgen@0.2.99
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	windows-core@0.52.0
	windows-link@0.2.1
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.20
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	xdg-home@1.3.0
	zbus@4.4.0
	zbus_macros@4.4.0
	zbus_names@3.0.0
	zerocopy-derive@0.8.27
	zerocopy@0.8.27
	zvariant@4.2.0
	zvariant_derive@4.2.0
	zvariant_utils@2.1.0
"

inherit cargo tmpfiles

DESCRIPTION="Clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

SRC_URI="
	https://github.com/rharish101/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/regreet"

RDEPEND="
	dev-libs/glib
	gui-libs/greetd
	gui-libs/gtk
	media-libs/graphene
	sys-apps/accountsservice
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
"

DOCS=(
	README.md
	regreet.sample.toml
)

IUSE="systemd"

src_configure() {
	local myfeatures=(
		gtk4_8
	)

	cargo_src_configure
}

src_prepare() {
	default

	sed -i 's/greeter/greetd/g' "${S}/systemd-tmpfiles.conf" || die
}

src_install() {
	cargo_src_install

	if use systemd; then
		newtmpfiles "${S}/systemd-tmpfiles.conf" regreet.conf
	else
		keepdir /var/log/regreet
		fowners greetd:greetd /var/log/regreet
		fperms 0755 /var/log/regreet

		keepdir /var/lib/regreet
		fowners greetd:greetd /var/lib/regreet
		fperms 0755 /var/lib/regreet
	fi

	einstalldocs
}

pkg_postinst() {
	if use systemd; then
		# Run systemd-tmpfiles to create the log and cache folder
		tmpfiles_process regreet.conf
	fi
}
