# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.7
	aho-corasick@1.1.2
	android_system_properties@0.1.5
	anstream@0.6.11
	anstyle@1.0.4
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.79
	async-trait@0.1.77
	autocfg@1.1.0
	backtrace@0.3.69
	bitflags@1.3.2
	bumpalo@3.14.0
	bytes@1.5.0
	cairo-rs@0.16.7
	cairo-sys-rs@0.16.3
	cc@1.0.83
	cfg-expr@0.15.6
	cfg-if@1.0.0
	chrono@0.4.23
	clap@4.4.18
	clap_builder@4.4.18
	clap_derive@4.4.7
	clap_lex@0.6.0
	colorchoice@1.0.0
	const_format@0.2.32
	const_format_proc_macros@0.2.32
	core-foundation-sys@0.8.6
	crc32fast@1.3.2
	crossbeam-channel@0.5.11
	crossbeam-utils@0.8.19
	deranged@0.3.11
	derivative@2.2.0
	equivalent@1.0.1
	field-offset@0.3.6
	file-rotate@0.7.5
	flate2@1.0.28
	flume@0.10.14
	fragile@2.0.0
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gdk-pixbuf@0.16.7
	gdk-pixbuf-sys@0.16.3
	gdk4@0.5.5
	gdk4-sys@0.5.5
	getrandom@0.2.12
	gimli@0.28.1
	gio@0.16.7
	gio-sys@0.16.3
	glib@0.16.9
	glib-macros@0.16.8
	glib-sys@0.16.3
	glob@0.3.1
	gobject-sys@0.16.3
	graphene-rs@0.16.3
	graphene-sys@0.16.3
	greetd_ipc@0.9.0
	gsk4@0.5.5
	gsk4-sys@0.5.5
	gtk4@0.5.5
	gtk4-macros@0.5.6
	gtk4-sys@0.5.5
	hashbrown@0.12.3
	hashbrown@0.13.2
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.3.4
	iana-time-zone@0.1.59
	iana-time-zone-haiku@0.1.2
	indexmap@1.9.3
	indexmap@2.1.0
	itoa@1.0.10
	js-sys@0.3.67
	lazy_static@1.4.0
	libc@0.2.152
	lock_api@0.4.11
	log@0.4.20
	lru@0.9.0
	memchr@2.7.1
	memoffset@0.9.0
	miniz_oxide@0.7.1
	mio@0.8.10
	nanorand@0.7.0
	nom8@0.2.0
	nu-ansi-term@0.46.0
	num-integer@0.1.45
	num-traits@0.2.17
	num_cpus@1.16.0
	num_threads@0.1.6
	object@0.32.2
	once_cell@1.19.0
	overload@0.1.1
	pango@0.16.5
	pango-sys@0.16.3
	pin-project@1.1.3
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.29
	powerfmt@0.2.0
	proc-macro-crate@1.3.1
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.78
	pwd@1.4.0
	quote@1.0.35
	regex@1.10.3
	regex-automata@0.4.4
	regex-syntax@0.8.2
	relm4@0.5.1
	relm4-macros@0.5.1
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	ryu@1.0.16
	scopeguard@1.2.0
	semver@1.0.21
	serde@1.0.195
	serde_derive@1.0.195
	serde_json@1.0.111
	serde_spanned@0.6.5
	sharded-slab@0.1.7
	shlex@1.3.0
	slab@0.4.9
	smallvec@1.13.1
	socket2@0.5.5
	spin@0.9.8
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.48
	system-deps@6.2.0
	target-lexicon@0.12.13
	thiserror@1.0.56
	thiserror-impl@1.0.56
	thread_local@1.1.7
	time@0.3.31
	time-core@0.1.2
	time-macros@0.2.16
	tokio@1.35.1
	toml@0.6.0
	toml@0.8.8
	toml_datetime@0.5.1
	toml_datetime@0.6.5
	toml_edit@0.18.1
	toml_edit@0.19.15
	toml_edit@0.21.0
	tracing@0.1.40
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracker@0.2.1
	tracker-macros@0.2.1
	unicode-ident@1.0.12
	unicode-xid@0.2.4
	utf8parse@0.2.1
	valuable@0.1.0
	version-compare@0.1.1
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.90
	wasm-bindgen-backend@0.2.90
	wasm-bindgen-macro@0.2.90
	wasm-bindgen-macro-support@0.2.90
	wasm-bindgen-shared@0.2.90
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
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
	winnow@0.5.34
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
"

inherit cargo readme.gentoo-r1 tmpfiles
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rharish101/${PN}.git"
else
	SRC_URI="
		https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> ${PN}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	|| ( gui-wm/sway gui-wm/cage )
	systemd? ( sys-apps/systemd[sysv-utils] )
	openrc? ( sys-apps/openrc[sysv-utils] )
	gui-libs/gtk
	gui-libs/greetd
"
BDEPEND="
	virtual/rust
	media-libs/graphene
"
IUSE="systemd openrc"

QA_FLAGS_IGNORED="usr/bin/regreet"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		unpack "${PN}.tar.gz"
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		gtk4_8
	)

	cargo_src_configure
}

src_prepare() {
	default
}

src_compile() {
	cargo_gen_config

	# Export default configuration
	export RUSTUP_TOOLCHAIN=stable
	export GREETD_CONFIG_DIR="/etc/greetd"
	export CACHE_DIR="/var/cache/regreet"
	export LOG_DIR="/var/log/regreet"
	export SESSION_DIRS="/usr/share/xsessions:/usr/share/wayland-sessions"
	# Require sysv-utils useflag enable on the init system
	export REBOOT_CMD="reboot"
	export POWEROFF_CMD="poweroff"

	cargo_src_compile
}

src_install() {
	cargo_src_install

	if use systemd; then
		newtmpfiles "${WORKDIR}/${P}/systemd-tmpfiles.conf" regreet.conf
	elif use openrc; then
		keepdir /var/log/regreet
		fowners greetd:greetd /var/log/regreet
		fperms 0755 /var/log/regreet

		keepdir /var/cache/regreet
		fowners greetd:greetd /var/cache/regreet
		fperms 0755 /var/cache/regreet
	fi
	# Install ReGreet template config file as a doc
	dodoc "${WORKDIR}/${P}/regreet.sample.toml"

	# Create README.gentoo doc file
	readme.gentoo_create_doc

	elog "ReGreet sample config file available on: /usr/share/doc/${P}/regreet.sample.toml.bz2"
	elog "To use decompress it to /etc/greetd/regreet.toml"

}

src_post_install () {
	if use systemd; then
		# Run systemd-tmpfiles to create the log and cache folder
		tmpfiles_process regreet.conf
	fi

	# Print README.gentoo file in the elog
	readme.gentoo_print_elog
}
