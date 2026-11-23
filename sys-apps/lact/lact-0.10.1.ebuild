# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	adler32@1.2.0
	aho-corasick@1.1.4
	allocator-api2@0.2.21
	amdgpu-sysfs@0.21.0
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.103
	arc-swap@1.9.2
	askama@0.15.6
	askama_derive@0.15.6
	askama_macros@0.15.6
	askama_parser@0.15.6
	async-broadcast@0.7.2
	async-recursion@1.1.1
	async-trait@0.1.89
	autocfg@1.5.1
	base64@0.22.1
	basic-toml@0.1.10
	bimap@0.6.3
	bindgen@0.71.1
	bindgen@0.72.1
	bitflags@1.3.2
	bitflags@2.13.0
	block-buffer@0.12.1
	bon-macros@3.9.3
	bon@3.9.3
	bumpalo@3.20.3
	bytes@1.12.1
	cairo-rs@0.22.0
	cairo-sys-rs@0.22.0
	cc@1.2.66
	cexpr@0.6.0
	cfg-expr@0.20.8
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	clang-sys@1.8.1
	clap@4.6.1
	clap_builder@4.6.0
	clap_derive@4.6.1
	clap_lex@1.1.0
	colorchoice@1.0.5
	concurrent-queue@2.5.0
	condtype@1.3.0
	console@0.16.4
	const-oid@0.10.2
	cookie@0.18.1
	cookie_store@0.22.1
	cpufeatures@0.3.0
	crc32fast@1.5.0
	crossbeam-utils@0.8.22
	crypto-common@0.2.2
	darling@0.20.11
	darling@0.23.0
	darling_core@0.20.11
	darling_core@0.23.0
	darling_macro@0.20.11
	darling_macro@0.23.0
	dary_heap@0.3.9
	defmt-macros@1.1.1
	defmt-parser@1.0.0
	defmt@1.1.1
	deranged@0.5.8
	diff@0.1.13
	digest@0.11.3
	displaydoc@0.2.6
	divan-macros@0.1.21
	divan@0.1.21
	document-features@0.2.12
	easy_fuser@0.5.0
	easy_fuser_macro@0.1.0
	either@1.16.0
	encode_unicode@1.0.0
	endi@1.1.1
	enum_dispatch@0.3.13
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	fastrand@2.4.1
	field-offset@0.3.6
	filetime@0.2.29
	find-crate@0.6.3
	find-msvc-tools@0.1.9
	flate2@1.1.9
	fluent-bundle@0.16.0
	fluent-langneg@0.13.1
	fluent-syntax@0.12.0
	fluent@0.17.0
	flume@0.12.0
	fnv@1.0.7
	foldhash@0.2.0
	form_urlencoded@1.2.2
	fragile@2.1.0
	fuser@0.16.0
	futures-channel@0.3.32
	futures-core@0.3.32
	futures-executor@0.3.32
	futures-io@0.3.32
	futures-lite@2.6.1
	futures-macro@0.3.32
	futures-sink@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	futures@0.3.32
	gdk-pixbuf-sys@0.22.0
	gdk-pixbuf@0.22.0
	gdk4-sys@0.11.4
	gdk4@0.11.4
	getrandom@0.2.17
	getrandom@0.3.4
	getrandom@0.4.3
	gio-sys@0.22.8
	gio@0.22.8
	glib-macros@0.22.6
	glib-sys@0.22.8
	glib@0.22.8
	glob@0.3.3
	gobject-sys@0.22.6
	graphene-rs@0.22.8
	graphene-sys@0.22.8
	gsk4-sys@0.11.4
	gsk4@0.11.4
	gtk4-macros@0.11.4
	gtk4-sys@0.11.4
	gtk4@0.11.4
	hashbrown@0.16.1
	hashbrown@0.17.1
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	http@1.4.2
	httparse@1.10.1
	hybrid-array@0.4.13
	i18n-config@0.4.8
	i18n-embed-fl@0.10.1
	i18n-embed-impl@0.8.4
	i18n-embed@0.16.0
	icu_collections@2.2.0
	icu_locale_core@2.2.0
	icu_normalizer@2.2.0
	icu_normalizer_data@2.2.0
	icu_properties@2.2.0
	icu_properties_data@2.2.0
	icu_provider@2.2.0
	ident_case@1.0.1
	idna@1.1.0
	idna_adapter@1.2.2
	indexmap@2.14.0
	inotify-sys@0.1.8
	inotify@0.11.4
	insta@1.48.0
	intl-memoizer@0.5.3
	intl_pluralrules@7.0.2
	is_terminal_polyfill@1.70.2
	itertools@0.13.0
	itoa@1.0.18
	jiff-static@0.2.32
	jiff-tzdb-platform@0.1.3
	jiff-tzdb@0.1.8
	jiff@0.2.32
	js-sys@0.3.103
	kqueue-sys@1.1.2
	kqueue@1.2.0
	lazy_static@1.5.0
	libadwaita-sys@0.9.2
	libadwaita@0.9.2
	libc@0.2.186
	libcopes@1.0.0
	libdisplay-info-derive@0.1.1
	libdisplay-info-sys@0.3.0
	libdisplay-info@0.3.0
	libdrm_amdgpu_sys@0.8.16
	libflate@2.3.0
	libflate_lz77@2.3.0
	libloading@0.8.9
	linux-raw-sys@0.12.1
	litemap@0.8.2
	litrs@1.0.0
	lock_api@0.4.14
	log@0.4.33
	matchers@0.2.0
	memchr@2.8.3
	memoffset@0.9.1
	mime@0.3.17
	mime_guess@2.0.5
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mio@1.2.1
	nix@0.29.0
	nix@0.31.3
	no_std_io2@0.9.4
	nom@7.1.3
	notify-types@2.1.0
	notify@8.2.0
	nu-ansi-term@0.50.3
	num-conv@0.2.2
	num-traits@0.2.19
	num_cpus@1.17.0
	num_threads@0.1.7
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	ordered-stream@0.2.0
	os-release@0.1.0
	page_size@0.6.0
	pango-sys@0.22.0
	pango@0.22.8
	parking@2.2.1
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pciid-parser@0.8.1
	percent-encoding@2.3.2
	pin-project-lite@0.2.17
	pkg-config@0.3.33
	plotters-backend@0.3.7
	plotters-cairo@0.9.0
	plotters@0.3.7
	portable-atomic-util@0.2.7
	portable-atomic@1.13.1
	potential_utf@0.1.5
	powerfmt@0.2.0
	pretty_assertions@1.4.1
	prettyplease@0.2.37
	proc-macro-crate@3.5.0
	proc-macro-error-attr3@3.1.0
	proc-macro-error3@3.1.0
	proc-macro2@1.0.106
	quote@1.0.46
	r-efi@5.3.0
	r-efi@6.0.0
	redox_syscall@0.5.18
	regex-automata@0.4.15
	regex-lite@0.1.9
	regex-syntax@0.8.11
	regex@1.13.0
	relm4-components@0.11.0
	relm4-css@0.11.0
	relm4-macros@0.11.0
	relm4@0.11.0
	ring@0.17.14
	rle-decode-fast@1.0.3
	rust-embed-impl@8.12.0
	rust-embed-utils@8.12.0
	rust-embed@8.12.0
	rustc-hash@2.1.3
	rustc_version@0.4.1
	rustix@1.1.4
	rustls-pki-types@1.15.0
	rustls-webpki@0.103.13
	rustls@0.23.41
	rustversion@1.0.23
	ryu@1.0.23
	same-file@1.0.6
	scopeguard@1.2.0
	self_cell@1.2.2
	semver@1.0.28
	serde-error@0.1.3
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.150
	serde_norway@0.9.42
	serde_repr@0.1.20
	serde_spanned@1.1.1
	serde_with@3.21.0
	serde_with_macros@3.21.0
	sha2@0.11.0
	sharded-slab@0.1.7
	shlex@1.3.0
	shlex@2.0.1
	signal-hook-registry@1.4.8
	simd-adler32@0.3.9
	similar@2.7.0
	slab@0.4.12
	smallvec@1.15.2
	socket2@0.6.4
	spin@0.9.8
	stable_deref_trait@1.2.1
	static_assertions@1.1.0
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.118
	syn@3.0.3
	synstructure@0.13.2
	sys-locale@0.3.2
	system-deps@7.0.8
	tar@0.4.46
	target-lexicon@0.13.5
	tempfile@3.27.0
	terminal_size@0.4.4
	thiserror-impl@1.0.69
	thiserror-impl@2.0.18
	thiserror@1.0.69
	thiserror@2.0.18
	thread-priority@3.1.1
	thread_local@1.1.10
	threadpool@1.8.1
	time-core@0.1.9
	time-macros@0.2.31
	time@0.3.53
	tinystr@0.8.3
	tokio-macros@2.7.0
	tokio@1.52.3
	toml@0.5.11
	toml@1.1.2+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.25.12+spec-1.1.0
	toml_parser@1.1.2+spec-1.1.0
	toml_writer@1.1.1+spec-1.1.0
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing-log@0.2.0
	tracing-subscriber@0.3.23
	tracing@0.1.44
	tracker-macros@0.2.3
	tracker@0.2.3
	type-map@0.5.1
	typenum@1.20.1
	uds_windows@1.2.1
	unic-langid-impl@0.9.6
	unic-langid@0.9.6
	unicase@2.9.0
	unicode-ident@1.0.24
	unsafe-libyaml-norway@0.2.15
	untrusted@0.9.0
	ureq-proto@0.6.0
	ureq@3.3.0
	url@2.5.8
	utf8-zero@0.8.1
	utf8_iter@1.0.4
	utf8parse@0.2.2
	uuid@1.23.4
	valuable@0.1.1
	vergen-gitcl@10.0.1
	vergen-lib@10.0.1
	vergen@10.0.1
	version-compare@0.2.1
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.4+wasi-0.2.12
	wasm-bindgen-macro-support@0.2.126
	wasm-bindgen-macro@0.2.126
	wasm-bindgen-shared@0.2.126
	wasm-bindgen@0.2.126
	web-sys@0.3.103
	webpki-roots@1.0.8
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.3.2
	windows-core@0.62.2
	windows-future@0.3.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-numerics@0.3.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.52.0
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows-targets@0.53.5
	windows-threading@0.2.1
	windows@0.62.2
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.1
	winnow@1.0.3
	wit-bindgen@0.57.1
	wrapcenum-derive@0.4.1
	writeable@0.6.3
	xattr@1.6.1
	yansi@1.0.1
	yoke-derive@0.8.2
	yoke@0.8.3
	zbus@5.17.0
	zbus_macros@5.17.0
	zbus_names@4.3.3
	zerocopy-derive@0.8.54
	zerocopy@0.8.54
	zerofrom-derive@0.1.7
	zerofrom@0.1.8
	zeroize@1.9.0
	zerotrie@0.2.4
	zerovec-derive@0.11.3
	zerovec@0.11.6
	zmij@1.0.21
	zvariant@5.13.0
	zvariant_derive@5.13.0
	zvariant_utils@3.5.0
"

declare -A GIT_CRATES=(
	[nvml-wrapper-sys]='https://github.com/rust-nvml/nvml-wrapper;eb47417eede43443f139053479618e96ad32893d;nvml-wrapper-%commit%/nvml-wrapper-sys'
	[nvml-wrapper]='https://github.com/rust-nvml/nvml-wrapper;eb47417eede43443f139053479618e96ad32893d;nvml-wrapper-%commit%/nvml-wrapper'
	[zbus_polkit]='https://github.com/ilya-zlobintsev/zbus_polkit;cebdd40f9f91780816427922e6c8aa41b4d59e66;zbus_polkit-%commit%'
)

LLVM_COMPAT=( {19..22} )
RUST_MIN_VER="1.97.0"

inherit cargo llvm-r2 xdg

DESCRIPTION="Linux GPU Control Application"
HOMEPAGE="https://github.com/ilya-zlobintsev/LACT"
SRC_URI="
	https://github.com/ilya-zlobintsev/LACT/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/${P^^}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0
	CDLA-Permissive-2.0 ISC LGPL-3+ MIT MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui test video_cards_nvidia"
REQUIRED_USE="test? ( gui )"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	!test? ( x11-libs/libdrm )
	test? ( x11-libs/libdrm[video_cards_amdgpu,video_cards_intel] )
	gui? (
		dev-libs/glib:2
		gnome-base/gsettings-desktop-schemas
		>=gui-libs/gtk-4.14:4
		>=gui-libs/libadwaita-1.5.0:1
		media-libs/graphene
		media-libs/libdisplay-info:0/3
		x11-libs/cairo
		x11-libs/pango
	)
"
RDEPEND="
	${COMMON_DEPEND}
	dev-util/clinfo
	sys-auth/polkit
	dev-util/vulkan-tools
	sys-apps/hwdata
"
DEPEND="
	${COMMON_DEPEND}
	test? ( sys-fs/fuse:3 )
"
# libclang is required for bindgen
BDEPEND="
	virtual/pkgconfig
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}')
"

QA_FLAGS_IGNORED="usr/bin/lact"

pkg_setup() {
	llvm-r2_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	default

	local crate crate_patches crate_uri commit crate_dir host
	for crate in "${!GIT_CRATES[@]}"; do
		IFS=';' read -r crate_uri commit crate_dir host <<< "${GIT_CRATES[${crate}]}"
		: "${crate_dir:=${crate}-%commit%}"
		crate_patches+="${crate} = { path = \"${WORKDIR}/${crate_dir//%commit%/${commit}}\" };;"
	done
	printf -- "[patch.crates-io]\\n%s" "${crate_patches//;;/$'\n'}" \
		>> "${CARGO_HOME}/config.toml"
}

src_configure() {
	local myfeatures=(
		$(usev gui lact-gui)
		$(usev gui display-info)
		$(usev video_cards_nvidia nvidia)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cargo_src_compile -p lact
}

src_install() {
	cargo_src_install --path lact
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install-resources
	newinitd res/lact-daemon-openrc lactd
}

src_test() {
	local CARGO_SKIP_TESTS=(
		# requires /dev/fuse access
		tests::apply_settings
	)
	cargo_src_test --workspace
}
