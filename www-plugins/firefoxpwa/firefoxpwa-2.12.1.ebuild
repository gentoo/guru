# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.25
	ab_glyph_rasterizer@0.1.8
	addr2line@0.21.0
	adler32@1.2.0
	adler@1.0.2
	aho-corasick@1.1.3
	aligned-vec@0.5.0
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.13
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.6
	anyhow@1.0.82
	arbitrary@1.3.2
	arg_enum_proc_macro@0.3.4
	arrayref@0.3.7
	arrayvec@0.7.4
	async-compression@0.4.9
	autocfg@1.2.0
	av1-grain@0.2.3
	avif-serialize@0.8.1
	backtrace@0.3.71
	base64@0.21.7
	base64@0.22.1
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.5.0
	bitstream-io@2.2.0
	blake3@1.5.1
	brotli-decompressor@4.0.0
	brotli@5.0.0
	built@0.7.2
	bumpalo@3.16.0
	bytemuck@1.15.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.6.0
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.4.4
	cc@1.0.96
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.2.0
	chrono@0.4.38
	clap@4.5.4
	clap_builder@4.5.2
	clap_complete@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	color_quant@1.1.0
	colorchoice@1.0.0
	configparser@3.0.4
	const_format@0.2.32
	const_format_proc_macros@0.2.32
	constant_time_eq@0.3.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	crc32fast@1.4.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	csscolorparser@0.6.2
	darling@0.20.8
	darling_core@0.20.8
	darling_macro@0.20.8
	data-url@0.3.1
	deflate@0.8.6
	deranged@0.3.11
	directories@5.0.1
	dirs-sys@0.4.1
	dmg@0.1.2
	either@1.11.0
	encoding_rs@0.8.34
	equivalent@1.0.1
	errno@0.3.8
	exr@1.72.0
	fastrand@2.1.0
	fdeflate@0.3.4
	filedescriptor@0.8.2
	filetime@0.2.23
	flate2@1.0.30
	float-cmp@0.9.0
	flume@0.11.0
	fnv@1.0.7
	fontconfig-parser@0.5.6
	fontdb@0.16.2
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs_extra@1.3.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-io@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gag@1.0.0
	getrandom@0.2.14
	gif@0.13.1
	gimli@0.28.1
	glob@0.3.1
	h2@0.4.4
	half@2.4.1
	hashbrown@0.12.3
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	http-body-util@0.1.1
	http-body@1.0.0
	http@1.1.0
	httparse@1.8.0
	hyper-tls@0.6.0
	hyper-util@0.1.3
	hyper@1.3.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	icns@0.3.1
	ident_case@1.0.1
	idna@0.5.0
	image-webp@0.1.2
	image@0.25.1
	imagesize@0.12.0
	imgref@1.10.1
	indexmap@1.9.3
	indexmap@2.2.6
	interpolate_name@0.2.4
	ipnet@2.9.0
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.31
	jpeg-decoder@0.3.1
	js-sys@0.3.69
	kurbo@0.11.0
	language-tags@0.3.2
	lazy_static@1.4.0
	lebe@0.5.2
	libc@0.2.154
	libfuzzer-sys@0.4.7
	libredox@0.1.3
	line-wrap@0.2.0
	linux-raw-sys@0.4.13
	lock_api@0.4.12
	log@0.4.21
	loop9@0.1.5
	maybe-rayon@0.1.1
	memchr@2.7.2
	memmap2@0.9.4
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.3.7
	miniz_oxide@0.7.2
	mio@0.8.11
	native-tls@0.2.11
	new_debug_unreachable@1.0.6
	nom@7.1.3
	noop_proc_macro@0.3.0
	num-bigint@0.4.4
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.1
	num-traits@0.2.18
	num_cpus@1.16.0
	num_threads@0.1.7
	object@0.32.2
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.3+3.2.1
	openssl-sys@0.9.102
	openssl@0.10.64
	option-ext@0.2.0
	owned_ttf_parser@0.20.0
	parse-display-derive@0.8.2
	parse-display@0.8.2
	paste@1.0.14
	percent-encoding@2.3.1
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-project@1.1.5
	pin-utils@0.1.0
	pix@0.13.3
	pkg-config@0.3.30
	plist@1.6.1
	png@0.16.8
	png@0.17.13
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.81
	profiling-procmacros@1.0.15
	profiling@1.0.15
	qoi@0.4.1
	quick-error@1.2.3
	quick-error@2.0.1
	quick-xml@0.31.0
	quote@1.0.36
	quoted-string@0.2.2
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rav1e@0.7.1
	ravif@0.11.5
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.4.1
	redox_users@0.4.5
	regex-automata@0.4.6
	regex-syntax@0.7.5
	regex-syntax@0.8.3
	regex@1.10.4
	reqwest@0.12.4
	resvg@0.41.0
	rgb@0.8.37
	roxmltree@0.19.0
	rustc-demangle@0.1.23
	rustix@0.38.34
	rustls-pemfile@2.1.2
	rustls-pki-types@1.5.0
	rustybuzz@0.13.0
	ryu@1.0.17
	sanitize-filename@0.5.0
	schannel@0.1.23
	scopeguard@1.2.0
	security-framework-sys@2.10.0
	security-framework@2.10.0
	serde@1.0.199
	serde_derive@1.0.199
	serde_json@1.0.116
	serde_spanned@0.6.5
	serde_urlencoded@0.7.1
	serde_with@3.8.1
	serde_with_macros@3.8.1
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	simplecss@0.2.1
	simplelog@0.12.2
	siphasher@0.3.11
	siphasher@1.0.1
	slab@0.4.9
	slotmap@1.0.7
	smallvec@1.13.2
	smart-default@0.7.1
	socket2@0.5.7
	spin@0.9.8
	strict-num@0.1.1
	strsim@0.10.0
	strsim@0.11.1
	structmeta-derive@0.2.0
	structmeta@0.2.0
	svgtypes@0.15.0
	syn@2.0.60
	sync_wrapper@0.1.2
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	system-deps@6.2.2
	tar@0.4.40
	target-lexicon@0.12.14
	tempfile@3.10.1
	termcolor@1.4.1
	thiserror-impl@1.0.59
	thiserror@1.0.59
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-native-tls@0.3.1
	tokio-socks@0.5.1
	tokio-util@0.7.10
	tokio@1.37.0
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.22.12
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	ttf-parser@0.20.0
	ulid@1.1.2
	unicode-bidi-mirroring@0.2.0
	unicode-bidi@0.3.15
	unicode-ccc@0.2.0
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-properties@0.1.1
	unicode-script@0.5.6
	unicode-vo@0.1.0
	unicode-xid@0.2.4
	url@2.5.0
	urlencoding@2.1.3
	usvg@0.41.0
	utf8parse@0.2.1
	v_frame@0.3.8
	vcpkg@0.2.15
	version-compare@0.2.0
	version_check@0.9.4
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	web-sys@0.3.69
	web-time@1.1.0
	weezl@0.1.8
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.6.7
	winreg@0.52.0
	xattr@1.3.1
	xmlwriter@0.1.0
	zstd-safe@7.1.0
	zstd-sys@2.0.10+zstd.1.5.6
	zstd@0.13.1
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.11
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
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD MIT MPL-2.0
	Unicode-DFS-2016 ZLIB
"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE="custom-cflags lto static"

# Add app-arch/bzip2 when it finally get pkg-config file
DEPEND="
	!static? (
		app-arch/zstd:=
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
			sys-devel/clang
			sys-devel/lld
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
		userchrome/profile/chrome/pwa/chrome.jsm || die
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

			# Fix -flto[=n] not being recognized by clang.
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
