# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.1
	adler2@2.0.0
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	annotate-snippets@0.9.2
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.87
	async-broadcast@0.7.1
	async-channel@2.3.1
	async-io@2.3.4
	async-lock@3.4.0
	async-pidfd-next@0.1.0
	async-process@2.2.4
	async-recursion@1.1.1
	async-signal@0.2.10
	async-task@4.7.1
	async-trait@0.1.82
	atomic-waker@1.1.2
	autocfg@1.3.0
	backon@1.2.0
	backtrace@0.3.74
	base64@0.13.1
	base64@0.21.7
	base64@0.22.1
	bindgen@0.69.4
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	blocking@1.6.1
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.7.1
	calendrical_calculations@0.1.1
	calibright@0.1.9
	cc@1.1.18
	cexpr@0.6.0
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	charset@0.1.5
	chrono-tz-build@0.3.0
	chrono-tz@0.9.0
	chrono@0.4.38
	clang-sys@1.7.0
	clap@4.5.17
	clap_builder@4.5.17
	clap_derive@4.5.13
	clap_lex@0.7.2
	clap_mangen@0.2.23
	colorchoice@1.0.2
	concurrent-queue@2.5.0
	convert_case@0.6.0
	cookie-factory@0.3.3
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	core_maths@0.1.0
	cpufeatures@0.2.14
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	darling@0.10.2
	darling_core@0.10.2
	darling_macro@0.10.2
	data-encoding@2.6.0
	debounced@0.2.0
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	displaydoc@0.2.5
	either@1.13.0
	encoding_rs@0.8.34
	endi@1.1.0
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	env_filter@0.1.2
	env_logger@0.11.5
	equivalent@1.0.1
	errno@0.3.9
	event-listener-strategy@0.5.2
	event-listener@5.3.1
	fastrand@2.1.1
	filetime@0.2.25
	fixed_decimal@0.5.6
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	from_variants@0.6.0
	from_variants_impl@0.6.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.3.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	futures@0.3.31
	generic-array@0.14.7
	gethostname@0.2.3
	getrandom@0.2.15
	gimli@0.31.0
	glob@0.3.1
	h2@0.3.26
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hex@0.4.3
	http-body@0.4.6
	http@0.2.12
	httparse@1.9.4
	httpdate@1.0.3
	humantime@2.1.0
	hyper-rustls@0.24.2
	hyper-tls@0.5.0
	hyper@0.14.30
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	icalendar@0.16.2
	icu_calendar@1.5.2
	icu_calendar_data@1.5.0
	icu_datetime@1.5.1
	icu_datetime_data@1.5.0
	icu_decimal@1.5.0
	icu_decimal_data@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.0
	icu_plurals@1.5.0
	icu_plurals_data@1.5.0
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	icu_timezone@1.5.0
	icu_timezone_data@1.5.0
	ident_case@1.0.1
	idna@0.5.0
	indexmap@2.5.0
	inotify-sys@0.1.5
	inotify@0.11.0
	inotify@0.9.6
	ipnet@2.10.0
	is_terminal_polyfill@1.70.1
	iso8601@0.6.1
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.11
	js-sys@0.3.70
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.158
	libloading@0.8.5
	libm@0.2.8
	libpulse-binding@2.28.1
	libpulse-sys@1.21.0
	libredox@0.1.3
	libsensors-sys@0.2.0
	libspa-sys@0.8.0
	libspa@0.8.0
	linux-raw-sys@0.4.14
	litemap@0.7.3
	log@0.4.22
	maildir@0.6.4
	mailparse@0.14.1
	memchr@2.7.4
	memoffset@0.9.1
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.8.0
	mio@0.8.11
	mio@1.0.2
	native-tls@0.2.12
	neli-proc-macros@0.1.3
	neli-wifi@0.6.0
	neli@0.6.4
	nix@0.27.1
	nix@0.29.0
	nom@7.1.3
	notify@6.1.1
	notmuch@0.8.0
	num-derive@0.3.3
	num-traits@0.2.19
	oauth2@4.4.2
	object@0.36.4
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.103
	openssl@0.10.66
	option-ext@0.2.0
	ordered-stream@0.2.0
	pandoc@0.8.11
	parking@2.2.1
	parse-zoneinfo@0.3.1
	percent-encoding@2.3.1
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	pipewire-sys@0.8.0
	pipewire@0.8.0
	pkg-config@0.3.30
	polling@3.7.3
	ppv-lite86@0.2.20
	proc-macro-crate@3.2.0
	proc-macro2@1.0.86
	pure-rust-locales@0.8.1
	quick-xml@0.36.1
	quote@1.0.37
	quoted_printable@0.5.1
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.3
	redox_users@0.4.6
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	reqwest@0.11.27
	ring@0.17.8
	roff@0.2.2
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustix@0.38.36
	rustls-pemfile@1.0.4
	rustls-webpki@0.101.7
	rustls@0.21.12
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.24
	sct@0.7.1
	security-framework-sys@2.11.1
	security-framework@2.11.1
	sensors@0.2.2
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_path_to_error@0.1.16
	serde_repr@0.1.19
	serde_spanned@0.6.7
	serde_urlencoded@0.7.1
	sha2@0.10.8
	shellexpand@3.1.0
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook-tokio@0.3.1
	signal-hook@0.3.17
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	smart-default@0.7.1
	socket2@0.5.7
	spin@0.9.8
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	strsim@0.11.1
	strsim@0.9.3
	swayipc-async@2.0.3
	swayipc-types@1.3.2
	syn@1.0.109
	syn@2.0.77
	sync_wrapper@0.1.2
	synstructure@0.13.1
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	system-deps@6.2.2
	target-lexicon@0.12.16
	tempfile@3.12.0
	thiserror-impl@1.0.63
	thiserror@1.0.63
	tinystr@0.7.6
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-macros@2.4.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-util@0.7.12
	tokio@1.40.0
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.20
	tower-service@0.3.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	typenum@1.17.0
	uds_windows@1.1.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.13
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-width@0.1.13
	untrusted@0.9.0
	url@2.5.2
	utf8parse@0.2.2
	uuid@1.8.0
	vcpkg@0.2.15
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-futures@0.4.43
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	wayrs-client@1.1.2
	wayrs-core@1.0.2
	wayrs-proto-parser@2.0.3
	wayrs-protocols@0.14.3
	wayrs-scanner@0.15.0
	web-sys@0.3.70
	webpki-roots@0.25.4
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
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
	winnow@0.6.18
	winreg@0.50.0
	writeable@0.5.5
	xdg-home@1.3.0
	yansi-term@0.1.2
	yoke-derive@0.7.4
	yoke@0.7.4
	zbus@5.0.0
	zbus_macros@5.0.0
	zbus_names@4.0.0
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zerofrom-derive@0.1.4
	zerofrom@0.1.4
	zerotrie@0.1.3
	zerovec-derive@0.10.3
	zerovec@0.10.4
	zvariant@5.0.0
	zvariant_derive@5.0.0
	zvariant_utils@3.0.0
"
RUST_MIN_VER="1.81.0"
LLVM_OPTIONAL=1
LLVM_COMPAT=( {18..19} )

inherit cargo llvm-r2 optfeature

DESCRIPTION="A feature-rich and resource-friendly replacement for i3status, written in Rust."
HOMEPAGE="https://github.com/greshake/i3status-rust/"
SRC_URI="${CARGO_CRATE_URIS}
	https://github.com/greshake/i3status-rust/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://git.sr.ht/~antecrescent/gentoo-files/blob/main/x11-misc/i3status-rust/${P}-man.1"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0
	GPL-3+ ISC MIT MPL-2.0 MirOS Unicode-3.0 Unicode-DFS-2016
"
# Manually added crate licenses
LICENSE+=" openssl"
SLOT="0"
KEYWORDS="~amd64"
IUSE="notmuch pipewire pulseaudio"
REQUIRED_USE="pipewire? ( ${LLVM_REQUIRED_USE} )"

DEPEND="dev-libs/openssl:=
	sys-apps/lm-sensors:=
	notmuch? ( net-mail/notmuch:= )
	pulseaudio? ( media-libs/libpulse )
	pipewire? ( >=media-video/pipewire-0.3:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	pipewire? ( $(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}') )
"

PATCHES="${FILESDIR}"/gitless-hash-and-date.patch

QA_FLAGS_IGNORED="usr/bin/i3status-rs"

pkg_setup() {
	if use pipewire; then
		llvm-r2_pkg_setup
	fi
	rust_pkg_setup
}

src_prepare() {
	default
	local COMMIT="be37f671934c7673037d83d7044b3a7b8d363271"
	local DATE="2024-11-09"
	sed -e "s/%COMMIT%/${COMMIT:0:9}/" -e "s/%DATE%/${DATE}/" \
		-i build.rs || die
}

src_configure() {
	local myfeatures=(
		$(usev debug debug_borders)
		$(usev notmuch)
		$(usev pipewire)
		icu_calendar
		maildir
	)
	cargo_src_configure $(usex pulseaudio '' --no-default-features)
}

src_install() {
	cargo_src_install
	newman "${DISTDIR}"/${P}-man.1 i3status-rs.1
	insinto /usr/share/i3status-rust
	doins -r files/icons files/themes
	dodoc NEWS.md CONTRIBUTING.md
	docinto examples
	dodoc examples/*.toml
}

pkg_postinst() {
	optfeature_header "Configurable fonts for themes and icons:"
	optfeature "themes using the Powerline arrow char" media-fonts/powerline-symbols
	optfeature "the awesome{5,6} icon set" media-fonts/fontawesome
	optfeature_header "Status bar blocks with additional requirements:"
	optfeature "ALSA volume support" media-sound/alsa-utils
	optfeature "advanced/non-standard battery support" sys-power/apcupsd sys-power/upower
	optfeature "bluetooth support" net-wireless/bluez
	optfeature "KDE Connect support" kde-misc/kdeconnect
	optfeature "speedtest support" net-analyzer/speedtest-cli
	# optfeature "VPN support" net-vpn/nordvpn # nordvpn overlay
	elog "The music block supports all music players that implement the MPRIS"
	elog "interface. These include media-sound/rhythmbox, media-sound/mpv and"
	elog "www-client/firefox among others. MPRIS support may be built-in or"
	elog "require additional plugins."
}
