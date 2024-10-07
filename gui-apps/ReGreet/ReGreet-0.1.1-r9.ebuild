# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	ahash@0.8.11
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.89
	async-trait@0.1.83
	autocfg@1.4.0
	backtrace@0.3.74
	bitflags@1.3.2
	bumpalo@3.16.0
	bytes@1.7.2
	cairo-rs@0.16.7
	cairo-sys-rs@0.16.3
	cc@1.1.28
	cfg-expr@0.15.8
	cfg-if@1.0.0
	chrono@0.4.38
	clap@4.5.19
	clap_builder@4.5.19
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	const_format@0.2.33
	const_format_proc_macros@0.2.33
	core-foundation-sys@0.8.7
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-utils@0.8.20
	deranged@0.3.11
	derivative@2.2.0
	equivalent@1.0.1
	field-offset@0.3.6
	file-rotate@0.7.6
	flate2@1.0.34
	flume@0.10.14
	fragile@2.0.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	gdk-pixbuf-sys@0.16.3
	gdk-pixbuf@0.16.7
	gdk4-sys@0.5.5
	gdk4@0.5.5
	getrandom@0.2.15
	gimli@0.31.1
	gio-sys@0.16.3
	gio@0.16.7
	glib-macros@0.16.8
	glib-sys@0.16.3
	glib@0.16.9
	glob@0.3.1
	gobject-sys@0.16.3
	graphene-rs@0.16.3
	graphene-sys@0.16.3
	greetd_ipc@0.9.0
	gsk4-sys@0.5.5
	gsk4@0.5.5
	gtk4-macros@0.5.6
	gtk4-sys@0.5.5
	gtk4@0.5.5
	hashbrown@0.12.3
	hashbrown@0.13.2
	hashbrown@0.15.0
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	indexmap@1.9.3
	indexmap@2.6.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	js-sys@0.3.70
	lazy_static@1.5.0
	libc@0.2.159
	lock_api@0.4.12
	log@0.4.22
	lru@0.9.0
	memchr@2.7.4
	memoffset@0.9.1
	miniz_oxide@0.8.0
	mio@1.0.2
	nanorand@0.7.0
	nom8@0.2.0
	nu-ansi-term@0.46.0
	num-conv@0.1.0
	num-traits@0.2.19
	num_threads@0.1.7
	object@0.36.5
	once_cell@1.20.2
	overload@0.1.1
	pango-sys@0.16.3
	pango@0.16.5
	pin-project-internal@1.1.6
	pin-project-lite@0.2.14
	pin-project@1.1.6
	pin-utils@0.1.0
	pkg-config@0.3.31
	powerfmt@0.2.0
	proc-macro-crate@1.3.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.86
	pwd@1.4.0
	quote@1.0.37
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	relm4-macros@0.5.1
	relm4@0.5.1
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	ryu@1.0.18
	scopeguard@1.2.0
	semver@1.0.23
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_spanned@0.6.8
	sharded-slab@0.1.7
	shlex@1.3.0
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.79
	system-deps@6.2.2
	target-lexicon@0.12.16
	thiserror-impl@1.0.64
	thiserror@1.0.64
	thread_local@1.1.8
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tokio@1.40.0
	toml@0.6.0
	toml@0.8.19
	toml_datetime@0.5.1
	toml_datetime@0.6.8
	toml_edit@0.18.1
	toml_edit@0.19.15
	toml_edit@0.22.22
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracing@0.1.40
	tracker-macros@0.2.2
	tracker@0.2.2
	unicode-ident@1.0.13
	unicode-xid@0.2.6
	utf8parse@0.2.2
	valuable@0.1.0
	version-compare@0.2.0
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.6.20
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo readme.gentoo-r1 tmpfiles
DESCRIPTION="A clean and customizable GTK-based greetd greeter written in Rust"
HOMEPAGE="https://github.com/rharish101/ReGreet"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rharish101/${PN}.git"
else
	SRC_URI="
		https://github.com/rharish101/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
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
	dev-libs/glib
	media-libs/graphene
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
"
BDEPEND="
	virtual/rust
"
IUSE="systemd openrc"

PATCHES="${FILESDIR}/ReGreet-0.1.1-cargo-lock-fix.diff"

QA_FLAGS_IGNORED="/usr/bin/regreet"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		unpack "${P}.tar.gz"
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

	if use systemd; then
		sed -i 's/greeter/greetd/g' "${S}/systemd-tmpfiles.conf" || die
	fi
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
		newtmpfiles "${S}/systemd-tmpfiles.conf" regreet.conf
	elif use openrc; then
		keepdir /var/log/regreet
		fowners greetd:greetd /var/log/regreet
		fperms 0755 /var/log/regreet

		keepdir /var/cache/regreet
		fowners greetd:greetd /var/cache/regreet
		fperms 0755 /var/cache/regreet
	fi
	# Install ReGreet template config file as a doc
	dodoc "${S}/regreet.sample.toml"

	# Create README.gentoo doc file
	readme.gentoo_create_doc

	elog "ReGreet sample config file available on: /usr/share/doc/${P}/regreet.sample.toml.bz2"
	elog "To use decompress it to /etc/greetd/regreet.toml"

}

src_post_install() {
	if use systemd; then
		# Run systemd-tmpfiles to create the log and cache folder
		tmpfiles_process regreet.conf
	fi

	# Print README.gentoo file in the elog
	readme.gentoo_print_elog
}
