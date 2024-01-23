# Copyright 20232-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph@0.2.23
	ab_glyph_rasterizer@0.1.8
	addr2line@0.21.0
	adler32@1.2.0
	adler@1.0.2
	aho-corasick@1.1.2
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.11
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.4
	anyhow@1.0.79
	arrayref@0.3.7
	arrayvec@0.7.4
	async-compression@0.4.6
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.7
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.4.2
	brotli-decompressor@2.5.1
	brotli@3.4.0
	bumpalo@3.14.0
	bytemuck@1.14.0
	byteorder@1.5.0
	bytes@1.5.0
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.4.4
	cc@1.0.83
	cfg-if@1.0.0
	cfg_aliases@0.2.0
	chrono@0.4.31
	clap@4.4.18
	clap_builder@4.4.18
	clap_complete@4.4.8
	clap_derive@4.4.7
	clap_lex@0.6.0
	color_quant@1.1.0
	colorchoice@1.0.0
	configparser@3.0.4
	const_format@0.2.32
	const_format_proc_macros@0.2.32
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	crc32fast@1.3.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	csscolorparser@0.6.2
	darling@0.20.3
	darling_core@0.20.3
	darling_macro@0.20.3
	data-url@0.3.1
	deflate@0.8.6
	deranged@0.3.11
	directories@5.0.1
	dirs-sys@0.4.1
	dmg@0.1.2
	either@1.9.0
	encoding_rs@0.8.33
	equivalent@1.0.1
	errno@0.3.8
	exr@1.71.0
	fastrand@2.0.1
	fdeflate@0.3.4
	filedescriptor@0.8.2
	filetime@0.2.23
	flate2@1.0.28
	float-cmp@0.9.0
	flume@0.11.0
	fnv@1.0.7
	fontconfig-parser@0.5.3
	fontdb@0.16.0
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
	getrandom@0.2.12
	gif@0.12.0
	gimli@0.28.1
	glob@0.3.1
	h2@0.3.24
	half@2.2.1
	hashbrown@0.12.3
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.3.4
	hex@0.4.3
	http-body@0.4.6
	http@0.2.11
	httparse@1.8.0
	httpdate@1.0.3
	hyper-tls@0.5.0
	hyper@0.14.28
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.59
	icns@0.3.1
	ident_case@1.0.1
	idna@0.5.0
	image@0.24.8
	imagesize@0.12.0
	indexmap@1.9.3
	indexmap@2.1.0
	ipnet@2.9.0
	itoa@1.0.10
	jpeg-decoder@0.3.1
	js-sys@0.3.67
	kurbo@0.9.5
	language-tags@0.3.2
	lazy_static@1.4.0
	lebe@0.5.2
	libc@0.2.152
	libredox@0.0.1
	line-wrap@0.1.1
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	log@0.4.20
	memchr@2.7.1
	memmap2@0.9.3
	mime@0.3.17
	miniz_oxide@0.3.7
	miniz_oxide@0.7.1
	mio@0.8.10
	native-tls@0.2.11
	num-traits@0.2.17
	num_cpus@1.16.0
	num_threads@0.1.6
	object@0.32.2
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.1+3.2.0
	openssl-sys@0.9.99
	openssl@0.10.63
	option-ext@0.2.0
	owned_ttf_parser@0.20.0
	parse-display-derive@0.8.2
	parse-display@0.8.2
	percent-encoding@2.3.1
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pix@0.13.3
	pkg-config@0.3.29
	plist@1.6.0
	png@0.16.8
	png@0.17.11
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.78
	qoi@0.4.1
	quick-error@1.2.3
	quick-xml@0.31.0
	quote@1.0.35
	quoted-string@0.2.2
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.8.1
	rctree@0.5.0
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex-automata@0.4.3
	regex-syntax@0.7.5
	regex-syntax@0.8.2
	regex@1.10.2
	reqwest@0.11.23
	resvg@0.37.0
	rgb@0.8.37
	roxmltree@0.18.1
	roxmltree@0.19.0
	rustc-demangle@0.1.23
	rustix@0.38.30
	rustybuzz@0.12.1
	ryu@1.0.16
	safemem@0.3.3
	sanitize-filename@0.5.0
	schannel@0.1.23
	scopeguard@1.2.0
	security-framework-sys@2.9.1
	security-framework@2.9.2
	serde@1.0.195
	serde_derive@1.0.195
	serde_json@1.0.111
	serde_urlencoded@0.7.1
	serde_with@3.5.0
	serde_with_macros@3.5.0
	simd-adler32@0.3.7
	simplecss@0.2.1
	simplelog@0.12.1
	siphasher@0.3.11
	slab@0.4.9
	slotmap@1.0.7
	smallvec@1.13.1
	smart-default@0.7.1
	socket2@0.5.5
	spin@0.9.8
	strict-num@0.1.1
	strsim@0.10.0
	structmeta-derive@0.2.0
	structmeta@0.2.0
	svgtypes@0.13.0
	syn@2.0.48
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	tar@0.4.40
	tempfile@3.9.0
	termcolor@1.1.3
	thiserror-impl@1.0.56
	thiserror@1.0.56
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.16
	time@0.3.31
	tiny-skia-path@0.11.3
	tiny-skia@0.11.3
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-native-tls@0.3.1
	tokio-socks@0.5.1
	tokio-util@0.7.10
	tokio@1.35.1
	tower-service@0.3.2
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	ttf-parser@0.20.0
	ulid@1.1.0
	unicode-bidi-mirroring@0.1.0
	unicode-bidi@0.3.15
	unicode-ccc@0.1.2
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-properties@0.1.1
	unicode-script@0.5.5
	unicode-vo@0.1.0
	unicode-xid@0.2.4
	url@2.5.0
	urlencoding@2.1.3
	usvg-parser@0.37.0
	usvg-text-layout@0.37.0
	usvg-tree@0.37.0
	usvg@0.37.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.90
	wasm-bindgen-futures@0.4.40
	wasm-bindgen-macro-support@0.2.90
	wasm-bindgen-macro@0.2.90
	wasm-bindgen-shared@0.2.90
	wasm-bindgen@0.2.90
	web-sys@0.3.67
	weezl@0.1.7
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
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
	winreg@0.50.0
	xattr@1.3.1
	xmlparser@0.13.6
	xmlwriter@0.1.0
	zune-inflate@0.2.54
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

# Main project license
LICENSE="MPL-2.0"

# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD MIT MPL-2.0 Unicode-DFS-2016 ZLIB"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="lto custom-cflags"

# Add app-arch/bzip2 when it finally get pkg-config file
DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"
# As Rust produces LLVM IR when using LTO, lld is needed to link. Furthermore,
# as some crates contain C code, clang should be used to compile them to produce
# compatible IR.
BDEPEND="
	virtual/pkgconfig
	lto? (
		!custom-cflags? (
			sys-devel/clang
			sys-devel/lld
		)
	)
"

QA_FLAGS_IGNORED="
	usr/bin/firefoxpwa
	usr/libexec/firefoxpwa-connector
"

S="${WORKDIR}/PWAsForFirefox-${PV}/native"

src_prepare() {
	default

	# Set version in source files as per build instructions
	sed -i "s/version = \"0.0.0\"/version = \"${PV}\"/g" Cargo.toml || die
	sed -i "s/DISTRIBUTION_VERSION = '0.0.0'/DISTRIBUTION_VERSION = '${PV}'/g" \
		userchrome/profile/chrome/pwa/chrome.jsm || die
}

src_configure() {
	strip-flags

	export CARGO_PROFILE_RELEASE_LTO=$(usex lto true false)

	if use lto; then
		if ! use custom-cflags; then
			# Fix -flto[=n] not being recognized by clang.
			tc-is-gcc && is-flag "-flto=*" && replace-flags "-flto=*" "-flto"
			CC="${CHOST}-clang"
			CXX="${CHOST}-clang++"
			RUSTFLAGS="-Clinker=clang -Clink-arg=-fuse-ld=lld ${RUSTFLAGS}"
		fi
	else
		filter-lto
	fi

	export PKG_CONFIG_ALLOW_CROSS=1
	export OPENSSL_NO_VENDOR=1
	cargo_src_configure
}

src_install() {
	# Executables
	dobin target/*/firefoxpwa
	exeinto /usr/libexec
	doexe target/*/firefoxpwa-connector

	# Manifest
	local target_dirs=( /usr/lib{,64}/mozilla/native-messaging-hosts )
	for target_dir in "${target_dirs[@]}"; do
		insinto "${target_dir}"
		newins manifests/linux.json firefoxpwa.json
	done

	# Completions
	newbashcomp target/*/completions/firefoxpwa.bash firefoxpwa
	dofishcomp target/*/completions/firefoxpwa.fish
	dozshcomp target/*/completions/_firefoxpwa

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
	echo "You have successfully installed the native part of the PWAsForFirefox project"
	echo "You should also install the Firefox extension if you haven't already"
	echo "Download: https://addons.mozilla.org/firefox/addon/pwas-for-firefox/"

	xdg_pkg_postinst
}

pkg_postrm() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		echo "Runtime, profiles and web apps are still installed in user directories"
		echo "You can remove them manually after this package is uninstalled"
		echo "Doing that will remove all installed web apps and their data"
	fi

	xdg_pkg_postrm
}
