# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )

CRATES="
	aho-corasick@1.1.5
	allocator-api2@0.2.21
	anes@0.1.6
	ansi-to-tui@8.0.1
	anstyle@1.0.14
	anyhow@1.0.104
	approx@0.5.1
	arrayvec@0.7.8
	assert_cmd@2.2.2
	assert_enum_variants@0.1.2
	atomic@0.6.1
	autocfg@1.5.1
	base64@0.22.1
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.13.2
	block-buffer@0.10.4
	bstr@1.13.1
	bumpalo@3.20.3
	by_address@1.2.1
	bytemuck@1.25.2
	bytes@1.12.1
	cast@0.3.0
	castaway@0.2.4
	cc@1.4.6
	cfg-if@1.0.4
	cfg_aliases@0.1.1
	cfg_aliases@0.2.2
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	ciborium@0.2.2
	clap@4.6.7
	clap_builder@4.6.7
	clap_lex@1.1.1
	compact_str@0.9.1
	convert_case@0.10.0
	cpufeatures@0.2.17
	criterion-plot@0.5.0
	criterion@0.6.0
	critical-section@1.2.0
	crossbeam-deque@0.8.8
	crossbeam-epoch@0.9.21
	crossbeam-utils@0.8.23
	crossterm@0.28.1
	crossterm@0.29.0
	crossterm_winapi@0.9.1
	crunchy@0.2.4
	crypto-common@0.1.7
	csscolorparser@0.6.2
	darling@0.20.11
	darling@0.24.1
	darling_core@0.20.11
	darling_core@0.24.1
	darling_macro@0.20.11
	darling_macro@0.24.1
	deltae@0.3.2
	deranged@0.5.8
	derive_builder@0.20.2
	derive_builder_core@0.20.2
	derive_builder_macro@0.20.2
	derive_more-impl@2.1.1
	derive_more@2.1.1
	difflib@0.4.0
	digest@0.10.7
	displaydoc@0.2.7
	document-features@0.2.12
	downcast-rs@1.2.1
	either@1.18.0
	equivalent@1.0.2
	erased-serde@0.4.10
	errno@0.3.14
	euclid@0.22.14
	eyre@0.6.14
	fancy-regex@0.11.0
	fastrand@2.5.0
	filedescriptor@0.8.3
	find-msvc-tools@0.1.12
	finl_unicode@1.4.0
	fixedbitset@0.4.2
	fnv@1.0.7
	foldhash@0.2.0
	futures-channel@0.3.34
	futures-core@0.3.34
	futures-executor@0.3.34
	futures-io@0.3.34
	futures-macro@0.3.34
	futures-sink@0.3.34
	futures-task@0.3.34
	futures-util@0.3.34
	futures@0.3.34
	generic-array@0.14.7
	gethostname@1.1.0
	getrandom@0.3.4
	getrandom@0.4.3
	half@2.7.1
	hashbrown@0.16.1
	hashbrown@0.17.1
	heck@0.5.0
	hex@0.4.3
	home@0.5.12
	humansize@2.1.3
	icu_collections@2.3.0
	icu_locale_core@2.3.0
	icu_locale_fallback@2.3.0
	icu_locale_fallback_data@2.3.0
	icu_provider@2.3.1
	icu_segmenter@2.3.0
	icu_segmenter_data@2.3.0
	ident_case@1.0.1
	indenter@0.3.4
	indexmap@2.14.2
	indoc@2.0.7
	instability@0.3.13
	itertools@0.10.5
	itertools@0.13.0
	itertools@0.14.0
	itoa@1.0.18
	jf@1.0.0
	js-sys@0.3.105
	kanal@0.1.1
	kasuari@0.4.12
	lab@0.11.0
	lazy_static@1.5.0
	libc@0.2.189
	libm@0.2.16
	libmimalloc-sys@0.1.44
	line-clipping@0.3.8
	linux-raw-sys@0.12.1
	linux-raw-sys@0.4.15
	litemap@0.8.3
	litrs@1.0.0
	lock_api@0.4.14
	log@0.4.34
	lru@0.18.4
	lscolors@0.21.0
	lua-src@551.0.2
	luajit-src@210.7.3+1ee778a
	mac_address@1.1.8
	memchr@2.8.3
	memmem@0.1.1
	memoffset@0.9.1
	mimalloc@0.1.48
	mime@0.3.17
	mime_guess@2.0.5
	minimal-lexical@0.2.1
	mio@1.2.3
	mlua-sys@0.12.0
	mlua@0.12.1
	natord@1.0.9
	nix@0.28.0
	nix@0.29.0
	nix@0.31.3
	nom@7.1.3
	nom@8.0.0
	nu-ansi-term@0.50.3
	num-conv@0.2.2
	num-derive@0.4.2
	num-traits@0.2.19
	num_threads@0.1.7
	numtoa@0.2.4
	once_cell@1.21.4
	oorandom@11.1.5
	ordered-float@2.10.1
	ordered-float@4.6.0
	palette@0.7.7
	palette_derive@0.7.7
	palette_math@0.7.7
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	path-absolutize@4.0.1
	path-dedot@4.0.1
	pest@2.9.1
	pest_derive@2.9.1
	pest_generator@2.9.1
	pest_meta@2.9.1
	phf@0.11.3
	phf_codegen@0.11.3
	phf_generator@0.11.3
	phf_macros@0.11.3
	phf_shared@0.11.3
	pin-project-lite@0.2.17
	pkg-config@0.3.34
	plotters-backend@0.3.7
	plotters-svg@0.3.7
	plotters@0.3.7
	portable-atomic@1.15.0
	portable-pty@0.9.0
	potential_utf@0.1.6
	powerfmt@0.2.0
	predicates-core@1.0.10
	predicates-tree@1.0.13
	predicates@3.1.4
	proc-macro2@1.0.107
	quote@1.0.47
	r-efi@5.3.0
	r-efi@6.0.0
	rand@0.8.8
	rand_core@0.6.4
	ratatui-core@0.1.2
	ratatui-crossterm@0.1.2
	ratatui-macros@0.7.2
	ratatui-termina@0.1.0
	ratatui-termion@0.1.2
	ratatui-termwiz@0.1.2
	ratatui-widgets@0.3.2
	ratatui@0.30.2
	rayon-core@1.13.0
	rayon@1.12.0
	redox_syscall@0.5.18
	regex-automata@0.4.18
	regex-syntax@0.8.11
	regex@1.13.1
	roff@1.1.1
	rustc-hash@2.1.3
	rustc_version@0.4.1
	rustix@0.38.44
	rustix@1.1.4
	rustversion@1.0.23
	ryu@1.0.23
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.28
	serde-value@0.7.0
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.151
	serde_yaml@0.9.34+deprecated
	serial2@0.2.38
	sha2@0.10.9
	shared_library@0.1.9
	shell-quote@0.8.0
	shell-words@1.1.1
	shlex@2.0.1
	signal-hook-mio@0.2.5
	signal-hook-registry@1.4.8
	signal-hook@0.3.18
	simdutf8@0.1.5
	siphasher@1.0.3
	skim@5.7.0
	slab@0.4.12
	smallvec@1.16.1
	smawk@0.3.3
	snailquote@0.3.1
	socket2@0.6.5
	stable_deref_trait@1.2.1
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.28.0
	strum_macros@0.28.0
	syn@1.0.109
	syn@2.0.119
	syn@3.0.5
	synstructure@0.13.2
	tempfile@3.27.0
	termina@0.3.3
	terminfo@0.9.0
	termion@4.0.6
	termios@0.3.3
	termtree@0.5.1
	termwiz@0.23.3
	textwrap@0.16.4
	thiserror-impl@1.0.69
	thiserror-impl@2.0.20
	thiserror@1.0.69
	thiserror@2.0.20
	thread_local@1.1.10
	time-core@0.1.9
	time-macros@0.2.32
	time@0.3.55
	tinystr@0.8.4
	tinytemplate@1.2.1
	tinyvec@1.13.3
	tokio-macros@2.7.2
	tokio-util@0.7.19
	tokio@1.53.1
	tui-input@0.15.4
	tui-term@0.3.4
	typeid@1.0.3
	typenum@1.20.1
	ucd-trie@0.1.7
	unicase@2.9.0
	unicode-display-width@0.3.0
	unicode-ident@1.0.24
	unicode-normalization@0.1.25
	unicode-segmentation@1.13.3
	unicode-truncate@2.0.1
	unicode-width@0.2.2
	unicode-xid@0.2.6
	unicode_categories@0.1.1
	unsafe-libyaml@0.2.11
	utf8_iter@1.0.4
	utf8parse@0.2.2
	uuid@1.26.1
	version_check@0.9.5
	vt100@0.16.2
	vte@0.15.0
	vtparse@0.6.2
	wait-timeout@0.2.1
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.4+wasi-0.2.12
	wasm-bindgen-macro-support@0.2.128
	wasm-bindgen-macro@0.2.128
	wasm-bindgen-shared@0.2.128
	wasm-bindgen@0.2.128
	web-sys@0.3.105
	wezterm-bidi@0.2.3
	wezterm-blob-leases@0.1.1
	wezterm-color-types@0.3.0
	wezterm-dynamic-derive@0.1.1
	wezterm-dynamic@0.2.1
	wezterm-input-types@0.1.0
	which@8.0.6
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
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
	winreg@0.10.1
	wit-bindgen@0.57.1
	writeable@0.6.4
	xdg@3.0.0
	yoke-derive@0.8.2
	yoke@0.8.3
	zerocopy-derive@0.8.57
	zerocopy@0.8.57
	zerofrom-derive@0.1.7
	zerofrom@0.1.8
	zerotrie@0.2.5
	zerovec-derive@0.11.6
	zerovec@0.11.8
	zmij@1.0.23
"

RUST_MIN_VER="1.91"

inherit cargo desktop lua-single xdg-utils

DESCRIPTION="A hackable, minimal, fast TUI file explorer"
HOMEPAGE="https://github.com/sayanarijit/xplr"
SRC_URI="
	https://github.com/sayanarijit/xplr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 GPL-3 MIT Unicode-3.0 Unicode-DFS-2016 WTFPL-2 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RDEPEND="
	${LUA_DEPS}
"
DEPEND="
	${RDEPEND}
"

QA_FLAGS_IGNORED="usr/bin/xplr"

pkg_setup() {
	lua-single_pkg_setup
	rust_pkg_setup
}

src_configure() {
	cargo_src_configure --bin xplr
}

src_prepare() {
	sed -i Cargo.toml -e "s/'vendored', //" || die
	# for dynamic linking with lua
	default
}

src_compile() {
	cargo_src_compile
}

src_install() {
	dodoc README.md

	dobin "$(cargo_target_dir)/xplr"
	newicon -s 16 "assets/icon/${PN}16.png" "${PN}.png"
	newicon -s 32 "assets/icon/${PN}32.png" "${PN}.png"
	newicon -s 64 "assets/icon/${PN}64.png" "${PN}.png"
	newicon -s 128 "assets/icon/${PN}128.png" "${PN}.png"
	doicon -s scalable "assets/icon/${PN}.svg"
	domenu assets/desktop/xplr.desktop
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
