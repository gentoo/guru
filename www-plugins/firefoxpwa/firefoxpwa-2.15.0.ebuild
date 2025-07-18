# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.31
	ab_glyph_rasterizer@0.1.9
	addr2line@0.24.2
	adler2@2.0.1
	adler32@1.2.0
	aho-corasick@1.1.3
	aligned-vec@0.6.4
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.19
	anstyle-parse@0.2.7
	anstyle-query@1.1.3
	anstyle-wincon@3.0.9
	anstyle@1.0.11
	anyhow@1.0.98
	arbitrary@1.4.1
	arg_enum_proc_macro@0.3.4
	arrayref@0.3.9
	arrayvec@0.7.6
	async-compression@0.4.27
	atomic-waker@1.1.2
	autocfg@1.5.0
	av1-grain@0.2.4
	avif-serialize@0.8.5
	backtrace@0.3.75
	base64@0.22.1
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.9.1
	bitstream-io@2.6.0
	blake3@1.8.2
	brotli-decompressor@5.0.0
	brotli@8.0.1
	built@0.7.7
	bumpalo@3.19.0
	bytemuck@1.23.1
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.10.1
	cc@1.2.30
	cfg-expr@0.15.8
	cfg-if@1.0.1
	cfg_aliases@0.2.1
	chrono@0.4.41
	clap@4.5.41
	clap_builder@4.5.41
	clap_complete@4.5.55
	clap_derive@4.5.41
	clap_lex@0.7.5
	color_quant@1.1.0
	colorchoice@1.0.4
	configparser@3.1.0
	const_format@0.2.34
	const_format_proc_macros@0.2.34
	constant_time_eq@0.3.1
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	core_maths@0.1.1
	crc32fast@1.5.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	csscolorparser@0.6.2
	darling@0.20.11
	darling_core@0.20.11
	darling_macro@0.20.11
	data-url@0.3.1
	deflate@0.8.6
	deranged@0.4.0
	directories@6.0.0
	dirs-sys@0.5.0
	displaydoc@0.2.5
	dmg@0.1.2
	dyn-clone@1.0.19
	either@1.15.0
	encoding_rs@0.8.35
	equator-macro@0.4.2
	equator@0.4.2
	equivalent@1.0.2
	errno@0.3.13
	exr@1.73.0
	fastrand@2.3.0
	fdeflate@0.3.7
	filedescriptor@0.8.3
	filetime@0.2.25
	flate2@1.1.2
	float-cmp@0.9.0
	fnv@1.0.7
	fontconfig-parser@0.5.8
	fontdb@0.23.0
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs_extra@1.3.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-io@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	gag@1.0.0
	getrandom@0.2.16
	getrandom@0.3.3
	gif@0.13.3
	gimli@0.31.1
	glob@0.3.2
	h2@0.4.11
	half@2.6.0
	hashbrown@0.12.3
	hashbrown@0.15.4
	heck@0.5.0
	hex@0.4.3
	http-body-util@0.1.3
	http-body@1.0.1
	http@1.3.1
	httparse@1.10.1
	hyper-rustls@0.27.7
	hyper-tls@0.6.0
	hyper-util@0.1.15
	hyper@1.6.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	icns@0.3.1
	icu_collections@2.0.0
	icu_locale_core@2.0.0
	icu_normalizer@2.0.0
	icu_normalizer_data@2.0.0
	icu_properties@2.0.1
	icu_properties_data@2.0.1
	icu_provider@2.0.0
	ident_case@1.0.1
	idna@1.0.3
	idna_adapter@1.2.1
	image-webp@0.2.3
	image@0.25.6
	imagesize@0.13.0
	imgref@1.11.0
	indexmap@1.9.3
	indexmap@2.10.0
	interpolate_name@0.2.4
	io-uring@0.7.8
	ipnet@2.11.0
	iri-string@0.7.8
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itoa@1.0.15
	jobserver@0.1.33
	jpeg-decoder@0.3.2
	js-sys@0.3.77
	kurbo@0.11.2
	language-tags@0.3.2
	lebe@0.5.2
	libc@0.2.174
	libfuzzer-sys@0.4.10
	libm@0.2.15
	libredox@0.1.4
	linux-raw-sys@0.9.4
	litemap@0.8.0
	log@0.4.27
	loop9@0.1.5
	lzma-sys@0.1.20
	maybe-rayon@0.1.1
	memchr@2.7.5
	memmap2@0.9.7
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.3.7
	miniz_oxide@0.8.9
	mio@1.0.4
	native-tls@0.2.14
	new_debug_unreachable@1.0.6
	nom@7.1.3
	noop_proc_macro@0.3.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	num_threads@0.1.7
	object@0.36.7
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	openssl-macros@0.1.1
	openssl-probe@0.1.6
	openssl-src@300.5.1+3.5.1
	openssl-sys@0.9.109
	openssl@0.10.73
	option-ext@0.2.0
	owned_ttf_parser@0.25.0
	parse-display-derive@0.8.2
	parse-display@0.8.2
	paste@1.0.15
	percent-encoding@2.3.1
	phf@0.11.3
	phf@0.12.1
	phf_generator@0.11.3
	phf_generator@0.12.1
	phf_macros@0.11.3
	phf_macros@0.12.1
	phf_shared@0.11.3
	phf_shared@0.12.1
	pico-args@0.5.0
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pix@0.14.0
	pkg-config@0.3.32
	plist@1.7.4
	png@0.16.8
	png@0.17.16
	potential_utf@0.1.2
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.95
	profiling-procmacros@1.0.17
	profiling@1.0.17
	qoi@0.4.1
	quick-error@1.2.3
	quick-error@2.0.1
	quick-xml@0.38.0
	quote@1.0.40
	quoted-string@0.2.2
	r-efi@5.3.0
	rand@0.8.5
	rand@0.9.1
	rand_chacha@0.3.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	rav1e@0.7.1
	ravif@0.11.20
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.13
	redox_users@0.5.0
	ref-cast-impl@1.0.24
	ref-cast@1.0.24
	regex-automata@0.4.9
	regex-syntax@0.7.5
	regex-syntax@0.8.5
	regex@1.11.1
	reqwest@0.12.22
	resvg@0.45.1
	rgb@0.8.52
	ring@0.17.14
	roxmltree@0.20.0
	rustc-demangle@0.1.25
	rustix@1.0.8
	rustls-pki-types@1.12.0
	rustls-webpki@0.103.4
	rustls@0.23.29
	rustversion@1.0.21
	rustybuzz@0.20.1
	ryu@1.0.20
	sanitize-filename@0.6.0
	schannel@0.1.27
	schemars@0.9.0
	schemars@1.0.4
	security-framework-sys@2.14.0
	security-framework@2.11.1
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.140
	serde_spanned@0.6.9
	serde_urlencoded@0.7.1
	serde_with@3.14.0
	serde_with_macros@3.14.0
	shlex@1.3.0
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	simplecss@0.2.2
	simplelog@0.12.2
	siphasher@1.0.1
	slab@0.4.10
	slotmap@1.0.7
	smallvec@1.15.1
	smart-default@0.7.1
	socket2@0.5.10
	stable_deref_trait@1.2.0
	strict-num@0.1.1
	strsim@0.11.1
	structmeta-derive@0.2.0
	structmeta@0.2.0
	subtle@2.6.1
	svgtypes@0.15.3
	syn@2.0.104
	sync_wrapper@1.0.2
	synstructure@0.13.2
	system-configuration-sys@0.6.0
	system-configuration@0.6.1
	system-deps@6.2.2
	tar@0.4.44
	target-lexicon@0.12.16
	tempfile@3.20.0
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	tiff@0.9.1
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tinystr@0.8.1
	tinyvec@1.9.0
	tinyvec_macros@0.1.1
	tokio-native-tls@0.3.1
	tokio-rustls@0.26.2
	tokio-util@0.7.15
	tokio@1.46.1
	toml@0.8.23
	toml_datetime@0.6.11
	toml_edit@0.22.27
	tower-http@0.6.6
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.5.2
	tracing-core@0.1.34
	tracing@0.1.41
	try-lock@0.2.5
	ttf-parser@0.25.1
	ulid@1.2.1
	unicode-bidi-mirroring@0.4.0
	unicode-bidi@0.3.18
	unicode-ccc@0.4.0
	unicode-ident@1.0.18
	unicode-properties@0.1.3
	unicode-script@0.5.7
	unicode-vo@0.1.0
	unicode-xid@0.2.6
	untrusted@0.9.0
	url@2.5.4
	urlencoding@2.1.3
	usvg@0.45.1
	utf8_iter@1.0.4
	utf8parse@0.2.2
	v_frame@0.3.9
	vcpkg@0.2.15
	version-compare@0.2.0
	version_check@0.9.5
	want@0.3.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-futures@0.4.50
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	web-sys@0.3.77
	web-time@1.1.0
	weezl@0.1.10
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.2.0
	windows-core@0.61.2
	windows-future@0.2.1
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-numerics@0.2.0
	windows-registry@0.5.3
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.52.6
	windows-targets@0.53.2
	windows-threading@0.1.0
	windows@0.61.3
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winnow@0.7.12
	wit-bindgen-rt@0.39.0
	writeable@0.6.1
	xattr@1.5.1
	xmlwriter@0.1.0
	xz2@0.1.7
	yoke-derive@0.8.0
	yoke@0.8.0
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize@1.8.1
	zerotrie@0.2.2
	zerovec-derive@0.11.1
	zerovec@0.11.2
	zstd-safe@7.2.4
	zstd-sys@2.0.15+zstd.1.5.7
	zstd@0.13.3
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.19
"

declare -A GIT_CRATES=(
	[mime-parse]='https://github.com/filips123/mime;57416f447a10c3343df7fe80deb0ae8a7c77cf0a;mime-%commit%/mime-parse'
	[mime]='https://github.com/filips123/mime;57416f447a10c3343df7fe80deb0ae8a7c77cf0a;mime-%commit%'
	[web_app_manifest]='https://github.com/filips123/WebAppManifestRS;477c5bbc7406eec01aea40e18338dafcec78c917;WebAppManifestRS-%commit%'
)

inherit cargo desktop flag-o-matic shell-completion toolchain-funcs xdg

DESCRIPTION="A tool to install, manage and use PWAs in Mozilla Firefox (native component)"
HOMEPAGE="https://pwasforfirefox.filips.si/"

SRC_URI="
	https://github.com/filips123/PWAsForFirefox/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/PWAsForFirefox-${PV}/native"

# Main project license
LICENSE="MPL-2.0"

# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD ISC MIT MPL-2.0
	UoI-NCSA Unicode-3.0 ZLIB
"

SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="custom-cflags lto static"

DEPEND="
	!static? (
		app-arch/zstd:=
		app-arch/xz-utils:=
		dev-libs/openssl:=
	)
"
RDEPEND="${DEPEND}"
# As Rust produces LLVM IR when using LTO, lld is needed to link. Furthermore,
# as some crates contain C code, clang should be used to compile them to produce
# compatible IR.
BDEPEND="
	lto? (
		!custom-cflags? (
			llvm-core/clang
			llvm-core/lld
		)
	)
	!static? ( virtual/pkgconfig )
"

QA_FLAGS_IGNORED="
	usr/bin/firefoxpwa
	usr/libexec/firefoxpwa-connector
"

src_prepare() {
	default

	# Set version in source files as per build instructions
	sed -i "s/version = \"0.0.0\"/version = \"${PV}\"/g" Cargo.toml || die
	sed -i "s/DISTRIBUTION_VERSION = '0.0.0'/DISTRIBUTION_VERSION = '${PV}'/g" \
		userchrome/profile/chrome/pwa/chrome.sys.mjs || die
}

src_configure() {
	# Setup toolchain
	export CARGO_PROFILE_RELEASE_LTO=$(usex lto true false)
	strip-flags

	if use lto; then
		if ! use custom-cflags; then
			CC="${CHOST}-clang"
			CXX="${CHOST}-clang++"
			RUSTFLAGS="-Clinker=clang -Clink-arg=-fuse-ld=lld ${RUSTFLAGS}"

			# Fix -flto[=n] not being recognized by clang
			if tc-is-clang && is-flag "-flto=*"; then
				replace-flags "-flto=*" "-flto"
			fi
		fi
	else
		filter-lto
	fi

	# Ask to use system dependencies
	if ! use static; then
		export PKG_CONFIG_ALLOW_CROSS=1
		export ZSTD_SYS_USE_PKG_CONFIG=1
		export OPENSSL_NO_VENDOR=1
	fi

	# Configure features
	local myfeatures=(
		$(usev static)
	)

	cargo_src_configure
}

src_install() {
	# Executables
	dobin $(cargo_target_dir)/firefoxpwa
	exeinto /usr/libexec
	doexe $(cargo_target_dir)/firefoxpwa-connector

	# Manifest
	local target_dirs=( /usr/lib{,64}/mozilla/native-messaging-hosts )
	for target_dir in "${target_dirs[@]}"; do
		insinto "${target_dir}"
		newins manifests/linux.json firefoxpwa.json
	done

	# Completions
	newbashcomp $(cargo_target_dir)/completions/firefoxpwa.bash firefoxpwa
	dofishcomp $(cargo_target_dir)/completions/firefoxpwa.fish
	dozshcomp $(cargo_target_dir)/completions/_firefoxpwa

	# UserChrome
	insinto /usr/share/firefoxpwa
	doins -r ./userchrome

	# Documentation
	dodoc ../README.md
	newdoc ../native/README.md README-NATIVE.md
	newdoc ../extension/README.md README-EXTENSION.md

	# AppStream Metadata
	insinto /usr/share/metainfo
	doins packages/appstream/si.filips.FirefoxPWA.metainfo.xml

	# Icon
	doicon -s scalable packages/appstream/si.filips.FirefoxPWA.svg
}

pkg_postinst() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog "You have successfully installed the native part of the PWAsForFirefox project."
		elog "You should also install the Firefox extension if you haven't already."
		elog
		elog "Download:"
		elog "\thttps://addons.mozilla.org/firefox/addon/pwas-for-firefox/"
	fi

	xdg_pkg_postinst
}

pkg_postrm() {
	if [[ ! ${REPLACED_BY_VERSION} ]]; then
		elog "Runtime, profiles and web apps are still installed in user directories."
		elog "You can remove them manually after this package is uninstalled."
		elog "Doing that will remove all installed web apps and their data."
	fi

	xdg_pkg_postrm
}
