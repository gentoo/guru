# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.89
	assert_cmd@2.0.16
	atomic-waker@1.1.2
	autocfg@1.4.0
	backtrace@0.3.74
	base64@0.22.1
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	brotli-decompressor@2.5.1
	brotli@3.5.0
	bstr@1.10.0
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.7.2
	cc@1.1.30
	cfg-if@1.0.0
	chardetng@0.1.17
	clap@4.5.20
	clap_builder@4.5.20
	clap_complete@4.5.33
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	console@0.15.8
	cookie@0.17.0
	cookie@0.18.1
	cookie_store@0.20.0
	cookie_store@0.21.0
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.14
	crc32fast@1.4.2
	crypto-common@0.1.6
	deranged@0.3.11
	difflib@0.4.0
	digest@0.10.7
	digest_auth@0.3.1
	dirs-sys@0.4.1
	dirs@5.0.1
	doc-comment@0.3.3
	either@1.13.0
	encode_unicode@0.3.6
	encoding_rs@0.8.34
	encoding_rs_io@0.1.7
	env_filter@0.1.2
	env_logger@0.11.5
	equivalent@1.0.1
	errno@0.3.9
	fastrand@2.1.1
	flate2@1.0.34
	float-cmp@0.9.0
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-io@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	generic-array@0.14.7
	getopts@0.2.21
	getrandom@0.2.15
	gimli@0.31.1
	h2@0.4.6
	hashbrown@0.12.3
	hashbrown@0.15.0
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	http-body-util@0.1.2
	http-body@1.0.1
	http@1.1.0
	httparse@1.9.5
	httpdate@1.0.3
	humantime@2.1.0
	hyper-rustls@0.27.3
	hyper-tls@0.6.0
	hyper-util@0.1.9
	hyper@1.4.1
	idna@0.3.0
	idna@0.5.0
	indexmap@1.9.3
	indexmap@2.6.0
	indicatif@0.17.8
	indoc@2.0.5
	instant@0.1.13
	ipnet@2.10.1
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	js-sys@0.3.72
	jsonxf@1.1.1
	lazy_static@1.5.0
	libc@0.2.159
	libredox@0.1.3
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.14
	log@0.4.22
	md-5@0.10.6
	memchr@2.7.4
	mime2ext@0.1.53
	mime@0.3.17
	mime_guess@2.0.5
	miniz_oxide@0.8.0
	mio@1.0.2
	native-tls@0.2.12
	network-interface@1.1.4
	normalize-line-endings@0.3.0
	num-conv@0.1.0
	num-traits@0.2.19
	number_prefix@0.4.0
	object@0.36.5
	once_cell@1.20.2
	onig@6.4.0
	onig_sys@69.8.1
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.103
	openssl@0.10.66
	option-ext@0.2.0
	os_display@0.1.3
	pem@3.0.4
	percent-encoding@2.3.1
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.31
	plist@1.7.0
	portable-atomic@1.9.0
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	predicates-core@1.0.8
	predicates-tree@1.0.11
	predicates@3.1.2
	proc-macro2@1.0.87
	psl-types@2.0.11
	publicsuffix@2.2.3
	quick-xml@0.32.0
	quinn-proto@0.11.8
	quinn-udp@0.5.5
	quinn@0.11.5
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_users@0.4.6
	regex-automata@0.4.8
	regex-lite@0.1.6
	regex-syntax@0.8.5
	regex@1.11.0
	reqwest@0.12.8
	ring@0.17.8
	roff@0.2.2
	rpassword@7.3.1
	rtoolbox@0.0.2
	rustc-demangle@0.1.24
	rustc-hash@2.0.0
	rustix@0.38.37
	rustls-native-certs@0.8.0
	rustls-pemfile@2.2.0
	rustls-pki-types@1.9.0
	rustls-webpki@0.102.8
	rustls@0.23.14
	ruzstd@0.7.2
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.26
	security-framework-sys@2.12.0
	security-framework@2.11.1
	serde-transcode@1.1.1
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_urlencoded@0.7.1
	sha2@0.10.8
	shlex@1.3.0
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	strsim@0.11.1
	subtle@2.6.1
	supports-hyperlinks@3.0.0
	syn@2.0.79
	sync_wrapper@1.0.1
	syntect@5.2.0
	system-configuration-sys@0.6.0
	system-configuration@0.6.1
	tempfile@3.13.0
	termcolor@1.4.1
	terminal_size@0.4.0
	termtree@0.4.1
	thiserror-impl@1.0.64
	thiserror@1.0.64
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-native-tls@0.3.1
	tokio-rustls@0.26.0
	tokio-socks@0.5.2
	tokio-util@0.7.12
	tokio@1.40.0
	tower-service@0.3.3
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	typenum@1.17.0
	unicase@2.7.0
	unicode-bidi@0.3.17
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	unicode-width@0.1.14
	untrusted@0.9.0
	url@2.5.2
	utf8parse@0.2.2
	vcpkg@0.2.15
	version_check@0.9.5
	wait-timeout@0.2.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-futures@0.4.45
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-shared@0.2.95
	wasm-bindgen@0.2.95
	web-sys@0.3.72
	webpki-roots@0.26.6
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-registry@0.2.0
	windows-result@0.2.0
	windows-strings@0.1.0
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
	yaml-rust@0.4.5
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
"

inherit cargo shell-completion

DESCRIPTION="Friendly and fast tool for sending HTTP requests"
HOMEPAGE="https://github.com/ducaale/xh"
SRC_URI="
	https://github.com/ducaale/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	dev-libs/oniguruma:=
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure() {
	# high magic to allow system-libs
	export OPENSSL_NO_VENDOR=true
	export RUSTONIG_SYSTEM_LIBONIG=1

	myfeatures=(
		native-tls
	)

	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	# See https://github.com/ducaale/xh#making-https-requests-by-default
	dosym "${PN}" "/usr/bin/${PN}s"

	einstalldocs
	doman "doc/${PN}.1"

	newbashcomp "completions/${PN}.bash" "${PN}"
	dozshcomp "completions/_${PN}"
	dofishcomp "completions/${PN}.fish"
}
