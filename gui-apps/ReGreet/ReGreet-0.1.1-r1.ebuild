# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	ahash-0.8.3
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anyhow-1.0.68
	async-trait-0.1.64
	autocfg-1.1.0
	bitflags-1.3.2
	bumpalo-3.12.0
	bytes-1.4.0
	cairo-rs-0.16.7
	cairo-sys-rs-0.16.3
	cc-1.0.78
	cfg-expr-0.11.0
	cfg-if-1.0.0
	chrono-0.4.23
	clap-4.1.4
	clap_derive-4.1.0
	clap_lex-0.3.1
	codespan-reporting-0.11.1
	const_format-0.2.30
	const_format_proc_macros-0.2.29
	core-foundation-sys-0.8.3
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-utils-0.8.14
	cxx-1.0.88
	cxx-build-1.0.88
	cxxbridge-flags-1.0.88
	cxxbridge-macro-1.0.88
	derivative-2.2.0
	errno-0.3.5
	field-offset-0.3.4
	file-rotate-0.7.2
	flate2-1.0.25
	flume-0.10.14
	fragile-2.0.0
	futures-0.3.26
	futures-channel-0.3.26
	futures-core-0.3.26
	futures-executor-0.3.26
	futures-io-0.3.26
	futures-macro-0.3.26
	futures-sink-0.3.26
	futures-task-0.3.26
	futures-util-0.3.26
	gdk-pixbuf-0.16.7
	gdk-pixbuf-sys-0.16.3
	gdk4-0.5.5
	gdk4-sys-0.5.5
	getrandom-0.2.8
	gio-0.16.7
	gio-sys-0.16.3
	glib-0.16.7
	glib-macros-0.16.3
	glib-sys-0.16.3
	glob-0.3.1
	gobject-sys-0.16.3
	graphene-rs-0.16.3
	graphene-sys-0.16.3
	greetd_ipc-0.9.0
	gsk4-0.5.5
	gsk4-sys-0.5.5
	gtk4-0.5.5
	gtk4-macros-0.5.5
	gtk4-sys-0.5.5
	hashbrown-0.12.3
	hashbrown-0.13.2
	heck-0.4.0
	hermit-abi-0.2.6
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	indexmap-1.9.2
	io-lifetimes-1.0.4
	is-terminal-0.4.2
	itoa-1.0.5
	js-sys-0.3.60
	lazy_static-1.4.0
	libc-0.2.139
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	lock_api-0.4.9
	log-0.4.17
	lru-0.9.0
	memchr-2.5.0
	memoffset-0.6.5
	miniz_oxide-0.6.2
	mio-0.8.6
	nanorand-0.7.0
	nom8-0.2.0
	nu-ansi-term-0.46.0
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.15.0
	num_threads-0.1.6
	once_cell-1.17.0
	os_str_bytes-6.4.1
	overload-0.1.1
	pango-0.16.5
	pango-sys-0.16.3
	pest-2.5.4
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.26
	proc-macro-crate-1.3.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.50
	pwd-1.4.0
	quote-1.0.23
	regex-1.7.1
	regex-syntax-0.6.28
	relm4-0.5.0
	relm4-macros-0.5.0
	rustc_version-0.3.3
	rustix-0.36.16
	ryu-1.0.12
	scopeguard-1.1.0
	scratch-1.0.3
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.152
	serde_derive-1.0.152
	serde_json-1.0.91
	serde_spanned-0.6.0
	sharded-slab-0.1.4
	shlex-1.1.0
	slab-0.4.7
	smallvec-1.10.0
	socket2-0.4.9
	spin-0.9.8
	strsim-0.10.0
	syn-1.0.107
	system-deps-6.0.3
	termcolor-1.2.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	thread_local-1.1.4
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tokio-1.26.0
	toml-0.5.11
	toml-0.6.0
	toml_datetime-0.5.1
	toml_edit-0.18.1
	tracing-0.1.37
	tracing-appender-0.2.2
	tracing-attributes-0.1.23
	tracing-core-0.1.30
	tracing-log-0.1.3
	tracing-subscriber-0.3.16
	tracker-0.2.0
	tracker-macros-0.2.0
	ucd-trie-0.1.5
	unicode-ident-1.0.6
	unicode-width-0.1.10
	unicode-xid-0.2.4
	valuable-0.1.0
	version-compare-0.1.1
	version_check-0.9.4
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows-sys-0.45.0
	windows-sys-0.48.0
	windows-targets-0.42.2
	windows-targets-0.48.5
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_gnullvm-0.48.5
	windows_aarch64_msvc-0.42.2
	windows_aarch64_msvc-0.48.5
	windows_i686_gnu-0.42.2
	windows_i686_gnu-0.48.5
	windows_i686_msvc-0.42.2
	windows_i686_msvc-0.48.5
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnu-0.48.5
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_gnullvm-0.48.5
	windows_x86_64_msvc-0.42.2
	windows_x86_64_msvc-0.48.5
"

inherit cargo
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

SRC_URI="
	https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> >${PN}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
SLOT="0"
DEPEND="x11-libs/gtk+:3
	gtk4? ( gui-libs/gtk )
"

KEYWORDS="~amd64"

RDEPEND="
	${DEPEND}
	gui-libs/greetd
"
BDEPEND="
	virtual/rust
"
IUSE="gtk4 logs"

src_configure() {
	if use gtk4; then
		local myfeatures=(
			gtk4_8
		)
	fi
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	newbin "${WORKDIR}/${P}/target/release/regreet" regreet
}

src_post_install () {
	if use logs; then
		insinto /etc/tmpfiles.d/ && newins "${WORKDIR}/${P}/systemd-tmpfiles.conf" regreet.conf
		systemd-tmpfiles --create "$PWD/systemd-tmpfiles.conf"
	fi
}
