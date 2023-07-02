# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph-0.2.18
	ab_glyph_rasterizer-0.1.7
	adler-1.0.2
	adler32-1.2.0
	aho-corasick-0.7.20
	alloc-no-stdlib-2.0.4
	alloc-stdlib-0.2.2
	android_system_properties-0.1.5
	anyhow-1.0.68
	arrayref-0.3.6
	arrayvec-0.7.2
	async-compression-0.4.0
	autocfg-1.1.0
	base64-0.13.1
	base64-0.21.0
	bit_field-0.10.1
	bitflags-1.3.2
	brotli-3.3.4
	brotli-decompressor-2.3.2
	bumpalo-3.11.1
	bytemuck-1.12.3
	byteorder-1.4.3
	bytes-1.3.0
	bzip2-0.4.4
	bzip2-sys-0.1.11+1.0.8
	cc-1.0.78
	cfg-if-1.0.0
	chrono-0.4.23
	clap-4.0.32
	clap_complete-4.0.7
	clap_derive-4.0.21
	clap_lex-0.3.0
	codespan-reporting-0.11.1
	color_quant-1.1.0
	configparser-3.0.2
	const_format-0.2.30
	const_format_proc_macros-0.2.29
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-utils-0.8.14
	crunchy-0.2.2
	csscolorparser-0.6.2
	cxx-1.0.89
	cxx-build-1.0.89
	cxxbridge-flags-1.0.89
	cxxbridge-macro-1.0.89
	darling-0.14.2
	darling_core-0.14.2
	darling_macro-0.14.2
	data-url-0.2.0
	deflate-0.8.6
	directories-4.0.1
	dirs-sys-0.3.7
	dmg-0.1.2
	either-1.8.0
	encoding_rs-0.8.31
	errno-0.2.8
	errno-dragonfly-0.1.2
	exr-1.5.2
	fastrand-1.8.0
	filedescriptor-0.8.2
	filetime-0.2.19
	flate2-1.0.25
	float-cmp-0.9.0
	flume-0.10.14
	fnv-1.0.7
	fontconfig-parser-0.5.1
	fontdb-0.10.0
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.1.0
	fs_extra-1.3.0
	futures-channel-0.3.25
	futures-core-0.3.25
	futures-io-0.3.25
	futures-sink-0.3.25
	futures-task-0.3.25
	futures-util-0.3.25
	gag-1.0.0
	getrandom-0.2.8
	gif-0.11.4
	glob-0.3.0
	h2-0.3.19
	half-2.1.0
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.2.6
	hex-0.4.3
	http-0.2.9
	http-body-0.4.5
	httparse-1.8.0
	httpdate-1.0.2
	hyper-0.14.26
	hyper-tls-0.5.0
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	icns-0.3.1
	ident_case-1.0.1
	idna-0.3.0
	image-0.24.5
	imagesize-0.10.1
	indexmap-1.9.2
	instant-0.1.12
	io-lifetimes-1.0.3
	ipnet-2.7.0
	is-terminal-0.4.2
	itoa-1.0.5
	jpeg-decoder-0.3.0
	js-sys-0.3.60
	kurbo-0.8.3
	language-tags-0.3.2
	lazy_static-1.4.0
	lebe-0.5.2
	libc-0.2.139
	line-wrap-0.1.1
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	lock_api-0.4.9
	log-0.4.17
	matches-0.1.9
	memchr-2.5.0
	memmap2-0.5.8
	memoffset-0.7.1
	mime-0.3.16
	miniz_oxide-0.3.7
	miniz_oxide-0.5.4
	miniz_oxide-0.6.2
	mio-0.8.5
	nanorand-0.7.0
	native-tls-0.2.11
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.15.0
	num_threads-0.1.6
	once_cell-1.17.0
	openssl-0.10.55
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-sys-0.9.90
	os_str_bytes-6.4.1
	owned_ttf_parser-0.17.1
	parse-display-0.8.0
	parse-display-derive-0.8.0
	percent-encoding-2.2.0
	phf-0.11.1
	phf_generator-0.11.1
	phf_macros-0.11.1
	phf_shared-0.11.1
	pico-args-0.5.0
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pix-0.13.2
	pkg-config-0.3.26
	plist-1.4.0
	png-0.16.8
	png-0.17.6
	ppv-lite86-0.2.17
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.49
	quick-error-1.2.3
	quick-xml-0.26.0
	quote-1.0.23
	quoted-string-0.2.2
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rayon-1.6.1
	rayon-core-1.10.1
	rctree-0.5.0
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.0
	regex-syntax-0.6.28
	reqwest-0.11.18
	resvg-0.27.0
	rgb-0.8.34
	roxmltree-0.15.1
	rustix-0.36.6
	rustybuzz-0.6.0
	ryu-1.0.12
	safemem-0.3.3
	sanitize-filename-0.4.0
	schannel-0.1.21
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	scratch-1.0.3
	security-framework-2.7.0
	security-framework-sys-2.6.1
	serde-1.0.152
	serde_derive-1.0.152
	serde_json-1.0.91
	serde_urlencoded-0.7.1
	serde_with-2.2.0
	serde_with_macros-2.2.0
	simplecss-0.2.1
	simplelog-0.12.0
	siphasher-0.3.10
	slab-0.4.7
	smallvec-1.10.0
	smart-default-0.6.0
	socket2-0.4.7
	spin-0.9.8
	strict-num-0.1.0
	strsim-0.10.0
	structmeta-0.1.5
	structmeta-derive-0.1.5
	svgfilters-0.4.0
	svgtypes-0.8.2
	syn-1.0.107
	tar-0.4.38
	tempfile-3.4.0
	termcolor-1.1.3
	thiserror-1.0.38
	thiserror-impl-1.0.38
	threadpool-1.8.1
	tiff-0.8.1
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tiny-skia-0.8.2
	tiny-skia-path-0.8.2
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tokio-1.25.0
	tokio-native-tls-0.3.0
	tokio-socks-0.5.1
	tokio-util-0.7.4
	tower-service-0.3.2
	tracing-0.1.37
	tracing-core-0.1.30
	try-lock-0.2.3
	ttf-parser-0.17.1
	ulid-1.0.0
	unicode-bidi-0.3.8
	unicode-bidi-mirroring-0.1.0
	unicode-ccc-0.1.2
	unicode-general-category-0.6.0
	unicode-ident-1.0.6
	unicode-normalization-0.1.22
	unicode-script-0.5.5
	unicode-vo-0.1.0
	unicode-width-0.1.10
	unicode-xid-0.2.4
	url-2.3.1
	urlencoding-2.1.2
	usvg-0.27.0
	vcpkg-0.2.15
	version_check-0.9.4
	want-0.3.0
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-futures-0.4.33
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	weezl-0.1.7
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.43.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_msvc-0.42.0
	windows_i686_gnu-0.42.0
	windows_i686_msvc-0.42.0
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_msvc-0.42.0
	winreg-0.10.1
	xattr-0.2.3
	xmlparser-0.13.5
"

RUST_URL_COMMIT="0032b9e8328f1a7ce2773f71adf316542ee8ddc9"
MIME_COMMIT="57416f447a10c3343df7fe80deb0ae8a7c77cf0a"
WEB_APP_MANIFEST_COMMIT="89ee187e6300bbd2d6f773651a4fcc07e4e7ede6"

declare -A GIT_CRATES=(
	[data-url]="https://github.com/filips123/rust-url;${RUST_URL_COMMIT};rust-url-%commit%/data-url"
	[web_app_manifest]="https://github.com/filips123/WebAppManifestRS;${WEB_APP_MANIFEST_COMMIT};WebAppManifestRS-%commit%"
	[mime]="https://github.com/filips123/mime;${MIME_COMMIT};mime-%commit%"
	[mime-parse]="https://github.com/filips123/mime;${MIME_COMMIT};mime-%commit%/mime-parse"
)

inherit cargo flag-o-matic

IUSE="lto"

DESCRIPTION="The native part of the PWAsForFirefox project"
HOMEPAGE="https://github.com/filips123/PWAsForFirefox"
SRC_URI="
	https://github.com/filips123/PWAsForFirefox/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

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

	export CARGO_PROFILE_release_LTO=$(usex lto true false)

	cargo_src_configure
}

src_install() {
	debug-print-function ${FUNCNAME}

	[[ ${_CARGO_GEN_CONFIG_HAS_RUN} ]] || \
		die "FATAL: please call cargo_gen_config before using ${FUNCNAME}"

	set -- cargo install --path ./ \
		--root ./ \
		${GIT_CRATES[@]:+--frozen} \
		$(usex debug --debug "") \
		${ECARGO_ARGS[@]} "$@"
	einfo "${@}"
	"${@}" || die "cargo install failed"

	TARGET_DIR=$(usex debug "debug" "release")

	# Executables
	into /usr
	dobin bin/firefoxpwa
	exeinto /usr/libexec
	doexe bin/firefoxpwa-connector

	# Plugin Manifest
	insinto /usr/lib64/mozilla/native-messaging-hosts
	newins manifests/linux.json firefoxpwa.json
	dosym ../../../lib64/mozilla/native-messaging-hosts/firefoxpwa.json \
		/usr/lib/mozilla/native-messaging-hosts/firefoxpwa.json

	# Shell Completions
	exeinto /usr/share/bash-completion/completions
	newexe target/${TARGET_DIR}/completions/firefoxpwa.bash firefoxpwa
	exeinto /usr/share/fish/vendor_completions.d
	doexe target/${TARGET_DIR}/completions/firefoxpwa.fish
	exeinto /usr/share/zsh/vendor-completions
	doexe target/${TARGET_DIR}/completions/_firefoxpwa

	# Documentation
	dodoc ../README.md
	newdoc ../native/README.md README-NATIVE.md
	newdoc ../extension/README.md README-EXTENSION.md
	dodoc packages/deb/copyright

	# UserChrome
	insinto /usr/share/firefoxpwa
	doins -r ./userchrome
}
