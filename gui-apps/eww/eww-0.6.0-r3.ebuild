# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.86
	ascii-canvas@3.0.0
	async-broadcast@0.7.1
	async-channel@2.3.1
	async-io@2.3.4
	async-lock@3.4.0
	async-process@2.2.4
	async-recursion@1.1.1
	async-signal@0.2.10
	async-task@4.7.1
	async-trait@0.1.81
	atk-sys@0.18.0
	atk@0.18.0
	atomic-waker@1.1.2
	autocfg@1.3.0
	backtrace@0.3.73
	base64@0.22.1
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	blocking@1.6.1
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.7.1
	cached@0.53.1
	cached_proc_macro@0.23.0
	cached_proc_macro_types@0.1.1
	cairo-rs@0.18.5
	cairo-sys-rs@0.18.2
	cc@1.1.14
	cfg-expr@0.15.8
	cfg-expr@0.16.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono-tz-build@0.3.0
	chrono-tz@0.9.0
	chrono@0.4.38
	chumsky@0.9.3
	clap@4.5.16
	clap_builder@4.5.15
	clap_complete@4.5.23
	clap_derive@4.5.13
	clap_lex@0.7.2
	codemap@0.1.3
	codespan-reporting@0.11.1
	colorchoice@1.0.2
	concurrent-queue@2.5.0
	console@0.15.8
	core-foundation-sys@0.8.7
	cpufeatures@0.2.13
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crunchy@0.2.2
	crypto-common@0.1.6
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	dbusmenu-glib-sys@0.1.0
	dbusmenu-glib@0.1.0
	dbusmenu-gtk3-sys@0.1.0
	dbusmenu-gtk3@0.1.0
	derive_more-impl@1.0.0
	derive_more@1.0.0
	diff@0.1.13
	digest@0.10.7
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dyn-clone@1.0.17
	either@1.13.0
	ena@0.14.3
	encode_unicode@0.3.6
	endi@1.1.0
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	env_logger@0.10.2
	equivalent@1.0.1
	errno@0.3.9
	event-listener-strategy@0.5.2
	event-listener@5.3.1
	extend@1.2.0
	fastrand@2.1.1
	field-offset@0.3.6
	filetime@0.2.24
	fixedbitset@0.4.2
	fnv@1.0.7
	fsevent-sys@4.1.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-lite@2.3.0
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.5
	gdk-sys@0.18.0
	gdk@0.18.0
	gdkx11-sys@0.18.0
	gdkx11@0.18.0
	generic-array@0.14.7
	gethostname@0.4.3
	getrandom@0.2.15
	gimli@0.29.0
	gio-sys@0.18.1
	gio@0.18.4
	glib-macros@0.18.5
	glib-sys@0.18.1
	glib@0.18.5
	gobject-sys@0.18.0
	grass@0.13.4
	grass_compiler@0.13.4
	gtk-layer-shell-sys@0.7.1
	gtk-layer-shell@0.8.1
	gtk-sys@0.18.0
	gtk3-macros@0.18.0
	gtk@0.18.1
	hashbrown@0.14.5
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hex@0.4.3
	hifijson@0.2.2
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	ident_case@1.0.1
	indexmap@2.4.0
	inotify-sys@0.1.5
	inotify@0.9.6
	insta@1.39.0
	is-terminal@0.4.13
	is_terminal_polyfill@1.70.1
	itertools@0.11.0
	itertools@0.13.0
	itoa@1.0.11
	jaq-core@1.5.1
	jaq-interpret@1.5.0
	jaq-parse@1.0.3
	jaq-std@1.6.0
	jaq-syn@1.6.0
	js-sys@0.3.70
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lalrpop-util@0.20.2
	lalrpop@0.20.2
	lasso@0.7.3
	lazy_static@1.5.0
	libc@0.2.158
	libm@0.2.8
	libredox@0.1.3
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	maplit@1.0.2
	memchr@2.7.4
	memoffset@0.9.1
	miniz_oxide@0.7.4
	mio@0.8.11
	mio@1.0.2
	new_debug_unreachable@1.0.6
	nix@0.29.0
	notify@6.1.1
	ntapi@0.4.1
	num-traits@0.2.19
	object@0.36.3
	once_cell@1.19.0
	ordered-stream@0.2.0
	pango-sys@0.18.0
	pango@0.18.3
	parking@2.2.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-zoneinfo@0.3.1
	petgraph@0.6.5
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.10.0
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.30
	polling@3.7.3
	ppv-lite86@0.2.20
	precomputed-hash@0.1.1
	pretty_assertions@1.4.0
	pretty_env_logger@0.5.0
	proc-macro-crate@1.3.1
	proc-macro-crate@2.0.0
	proc-macro-crate@3.1.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.86
	pure-rust-locales@0.8.1
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.3
	redox_users@0.4.6
	ref-cast-impl@1.0.23
	ref-cast@1.0.23
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.6
	rustc-demangle@0.1.24
	rustc_version@0.4.0
	rustix@0.38.34
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.23
	serde@1.0.209
	serde_derive@1.0.209
	serde_json@1.0.127
	serde_repr@0.1.19
	serde_spanned@0.6.7
	sha1@0.10.6
	shlex@1.3.0
	signal-hook-registry@1.4.2
	similar@2.6.0
	simple-signal@1.1.1
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	smart-default@0.7.1
	socket2@0.5.7
	static_assertions@1.1.0
	string_cache@0.8.7
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	syn@1.0.109
	syn@2.0.76
	sysinfo@0.31.3
	system-deps@6.2.2
	system-deps@7.0.2
	target-lexicon@0.12.16
	tempfile@3.12.0
	term@0.7.0
	termcolor@1.4.1
	thiserror-impl@1.0.63
	thiserror@1.0.63
	tiny-keccak@2.0.2
	tokio-macros@2.4.0
	tokio-util@0.7.11
	tokio@1.39.3
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.19.15
	toml_edit@0.20.7
	toml_edit@0.21.1
	toml_edit@0.22.20
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	typenum@1.17.0
	uds_windows@1.1.0
	unescape@0.1.0
	unicode-ident@1.0.12
	unicode-width@0.1.13
	unicode-xid@0.2.5
	urlencoding@2.1.3
	utf8parse@0.2.2
	version-compare@0.2.0
	version_check@0.9.5
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	web-time@1.1.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.57.0
	windows-implement@0.57.0
	windows-interface@0.57.0
	windows-result@0.1.2
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows@0.57.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.6.18
	x11@2.21.0
	x11rb-protocol@0.13.1
	x11rb@0.13.1
	xdg-home@1.3.0
	yansi@0.5.1
	zbus@4.4.0
	zbus_macros@4.4.0
	zbus_names@3.0.0
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zvariant@4.2.0
	zvariant_derive@4.2.0
	zvariant_utils@2.1.0
"

RUST_MIN_VER="1.74.0"

inherit cargo shell-completion

DESCRIPTION="Elkowars Wacky Widgets is a standalone widget system made in Rust"
HOMEPAGE="https://elkowar.github.io/eww/"
SRC_URI="https://git.sr.ht/~antecrescent/gentoo-files/blob/main/gui-apps/eww/${P}-shellcomp.tar.xz"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/elkowar/eww.git"
else
	SRC_URI+="
		https://github.com/elkowar/eww/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"

	PATCHES="${FILESDIR}/eww-0.6.0-update-crates.patch"
fi

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 ISC LGPL-3
	Unicode-DFS-2016
"
SLOT="0"
IUSE="X wayland"
REQUIRED_USE="|| ( X wayland )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu[gtk3]
	x11-libs/cairo[glib]
	x11-libs/gdk-pixbuf:2[jpeg]
	x11-libs/gtk+:3[X?,wayland?]
	x11-libs/pango
	wayland? ( gui-libs/gtk-layer-shell )
"
# transitively hard-depend on xorg-proto due to gdk-3.0.pc
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="usr/bin/.*"

src_unpack() {
	if [[ "${PV}" == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
		unpack ${P}-shellcomp.tar.xz
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev X x11)
		$(usev wayland wayland)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	dobashcomp "${WORKDIR}"/eww
	dofishcomp "${WORKDIR}"/eww.fish
	dozshcomp "${WORKDIR}"/_eww

	dodoc README.md CHANGELOG.md
	cargo_src_install --path crates/eww
}

pkg_postinst() {
	elog "Eww wont run without a config file (usually in ~/.config/eww)."
	elog "For example configs visit https://github.com/elkowar/eww#examples"
}
