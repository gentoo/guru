# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.8
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.11
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.6
	anyhow@1.0.79
	ascii-canvas@3.0.0
	atk-sys@0.17.0
	atk@0.17.1
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.7
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.2
	bumpalo@3.15.0
	bytes@1.5.0
	cached@0.48.1
	cached_proc_macro@0.19.1
	cached_proc_macro_types@0.1.1
	cairo-rs@0.17.10
	cairo-sys-rs@0.17.10
	cc@1.0.83
	cfg-expr@0.15.7
	cfg-if@1.0.0
	chrono-tz-build@0.2.1
	chrono-tz@0.8.6
	chrono@0.4.34
	chumsky@0.9.3
	clap@4.5.1
	clap_builder@4.5.1
	clap_complete@4.5.1
	clap_derive@4.5.0
	clap_lex@0.7.0
	codemap@0.1.3
	codespan-reporting@0.11.1
	colorchoice@1.0.0
	console@0.15.8
	convert_case@0.4.0
	core-foundation-sys@0.8.6
	crossbeam-channel@0.5.11
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	deranged@0.3.11
	derive_more@0.99.17
	diff@0.1.13
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dyn-clone@1.0.16
	either@1.10.0
	ena@0.14.2
	encode_unicode@0.3.6
	env_logger@0.10.2
	equivalent@1.0.1
	extend@1.2.0
	field-offset@0.3.6
	filetime@0.2.23
	fixedbitset@0.4.2
	fnv@1.0.7
	fsevent-sys@4.1.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	gdk-pixbuf-sys@0.17.10
	gdk-pixbuf@0.17.10
	gdk-sys@0.17.0
	gdk@0.17.1
	gdkx11-sys@0.17.0
	gdkx11@0.17.0
	gethostname@0.2.3
	getrandom@0.2.12
	gimli@0.28.1
	gio-sys@0.17.10
	gio@0.17.10
	glib-macros@0.17.10
	glib-sys@0.17.10
	glib@0.17.10
	gobject-sys@0.17.10
	grass@0.13.2
	grass_compiler@0.13.2
	gtk-layer-shell-sys@0.6.0
	gtk-layer-shell@0.6.1
	gtk-sys@0.17.0
	gtk3-macros@0.17.1
	gtk@0.17.1
	hashbrown@0.13.2
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.3.6
	hifijson@0.2.0
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	ident_case@1.0.1
	indexmap@2.2.3
	inotify-sys@0.1.5
	inotify@0.9.6
	insta@1.34.0
	instant@0.1.12
	is-terminal@0.4.12
	itertools@0.10.5
	itertools@0.12.1
	itoa@1.0.10
	jaq-core@1.2.1
	jaq-interpret@1.2.1
	jaq-parse@1.0.2
	jaq-std@1.2.1
	jaq-syn@1.1.0
	js-sys@0.3.68
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lalrpop-util@0.20.0
	lalrpop@0.20.0
	lasso@0.7.2
	lazy_static@1.4.0
	libc@0.2.153
	libm@0.2.8
	libredox@0.0.1
	linked-hash-map@0.5.6
	lock_api@0.4.11
	log@0.4.20
	maplit@1.0.2
	memchr@2.7.1
	memoffset@0.6.5
	memoffset@0.9.0
	miniz_oxide@0.7.2
	mio@0.8.10
	new_debug_unreachable@1.0.4
	nix@0.25.1
	nix@0.27.1
	notify@6.1.1
	ntapi@0.4.1
	num-conv@0.1.0
	num-traits@0.2.18
	num_cpus@1.16.0
	object@0.32.2
	once_cell@1.19.0
	pango-sys@0.17.10
	pango@0.17.10
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	parse-zoneinfo@0.3.0
	petgraph@0.6.4
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.10.0
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.30
	powerfmt@0.2.0
	precomputed-hash@0.1.1
	pretty_assertions@1.4.0
	pretty_env_logger@0.5.0
	proc-macro-crate@1.3.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.78
	quote@1.0.35
	rand@0.8.5
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.8.1
	redox_syscall@0.4.1
	redox_users@0.4.4
	ref-cast-impl@1.0.22
	ref-cast@1.0.22
	regex-automata@0.4.5
	regex-syntax@0.7.5
	regex-syntax@0.8.2
	regex@1.10.3
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustversion@1.0.14
	ryu@1.0.16
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.21
	serde@1.0.196
	serde_derive@1.0.196
	serde_json@1.0.113
	serde_spanned@0.6.5
	signal-hook-registry@1.4.1
	similar@2.4.0
	simple-signal@1.1.1
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.1
	smart-default@0.7.1
	socket2@0.5.5
	static_assertions@1.1.0
	string_cache@0.8.7
	strsim@0.10.0
	strsim@0.11.0
	strum@0.26.1
	strum_macros@0.26.1
	syn@1.0.109
	syn@2.0.49
	sysinfo@0.30.5
	system-deps@6.2.0
	target-lexicon@0.12.13
	term@0.7.0
	termcolor@1.4.1
	thiserror-impl@1.0.57
	thiserror@1.0.57
	time-core@0.1.2
	time-macros@0.2.17
	time@0.3.34
	tiny-keccak@2.0.2
	tokio-macros@2.2.0
	tokio-util@0.7.10
	tokio@1.36.0
	toml@0.8.10
	toml_datetime@0.6.5
	toml_edit@0.19.15
	toml_edit@0.22.6
	unescape@0.1.0
	unicode-ident@1.0.12
	unicode-width@0.1.11
	unicode-xid@0.2.4
	urlencoding@2.1.3
	utf8parse@0.2.1
	version-compare@0.1.1
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.91
	wasm-bindgen-macro-support@0.2.91
	wasm-bindgen-macro@0.2.91
	wasm-bindgen-shared@0.2.91
	wasm-bindgen@0.2.91
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows@0.52.0
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
	winnow@0.5.40
	winnow@0.6.1
	x11@2.21.0
	x11rb-protocol@0.11.1
	x11rb@0.11.1
	yaml-rust@0.4.5
	yansi@0.5.1
	zerocopy-derive@0.7.32
	zerocopy@0.7.32
"

inherit cargo

DESCRIPTION="Elkowars Wacky Widgets is a standalone widget system made in Rust"
HOMEPAGE="https://github.com/elkowar/eww"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/elkowar/${PN}.git"
else
	SRC_URI="
		https://github.com/elkowar/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="
	MIT
"
SLOT="0"
IUSE="X wayland"
REQUIRED_USE="|| ( X wayland )"

DEPEND="
	X? ( x11-libs/gtk+:3[X] )
	wayland? ( x11-libs/gtk+:3[wayland] )
	x11-libs/pango
	x11-libs/gdk-pixbuf
	x11-libs/cairo
	>=dev-libs/glib-2.0
	sys-devel/gcc
	gui-libs/gtk-layer-shell
"

QA_FLAGS_IGNORED="usr/bin/.*"

src_unpack() {
	if [[ "${PV}" == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev X x11)
		$(usev wayland wayland)
	)
	cargo_src_configure
}

src_compile() {
	cargo_gen_config
	cargo_src_compile
}

src_install() {
	dodoc README.md CHANGELOG.md
	cd target/release || die
	dobin eww
	elog "Eww wont run without a config file (usually in ~/.config/eww)."
	elog "For example configs visit https://github.com/elkowar/eww#examples"
}
