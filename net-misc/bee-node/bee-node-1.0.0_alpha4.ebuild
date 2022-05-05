# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	aead-0.4.3
	aes-0.7.5
	aes-gcm-0.9.4
	ahash-0.7.6
	aho-corasick-0.7.18
	anyhow-1.0.56
	anymap-0.12.1
	arrayref-0.3.6
	arrayvec-0.5.2
	arrayvec-0.7.2
	asn1_der-0.7.5
	async-channel-1.6.1
	async-priority-queue-0.1.1
	async-trait-0.1.52
	asynchronous-codec-0.6.0
	atomic-0.5.1
	atty-0.2.14
	auth-helper-0.1.0
	autocfg-1.1.0
	base64-0.12.3
	base64-0.13.0
	base64ct-1.4.1
	bech32-0.8.1
	bee-ternary-0.6.0
	bincode-1.3.3
	bindgen-0.59.2
	bitflags-1.3.2
	bitvec-0.20.4
	blake2-0.9.2
	blake2b_simd-0.5.11
	block-buffer-0.9.0
	block-buffer-0.10.2
	bs58-0.4.0
	bstr-0.2.17
	buf_redux-0.8.4
	bumpalo-3.9.1
	byte-slice-cast-1.2.1
	bytemuck-1.8.0
	byteorder-1.4.3
	bytes-1.1.0
	bzip2-0.4.3
	bzip2-sys-0.1.11+1.0.8
	cache-padded-1.2.0
	cap-0.1.0
	cast-0.2.7
	cc-1.0.73
	cexpr-0.6.0
	cfg-if-1.0.0
	chacha20-0.7.3
	chacha20poly1305-0.8.2
	chrono-0.4.19
	cipher-0.3.0
	clang-sys-1.3.1
	clap-2.34.0
	colored-1.9.3
	concurrent-queue-1.2.2
	const-oid-0.7.1
	constant_time_eq-0.1.5
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	cpufeatures-0.2.1
	crc32fast-1.3.2
	criterion-0.3.5
	criterion-plot-0.4.4
	crossbeam-channel-0.5.3
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.8
	crossbeam-utils-0.8.8
	crunchy-0.2.2
	crypto-common-0.1.3
	crypto-mac-0.8.0
	csv-1.1.6
	csv-core-0.1.10
	ctr-0.8.0
	curve25519-dalek-3.2.1
	dashmap-4.0.2
	data-encoding-2.3.2
	der-0.5.1
	derive_more-0.99.17
	digest-0.9.0
	digest-0.10.3
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	dtoa-0.4.8
	ed25519-1.4.0
	ed25519-dalek-1.0.1
	ed25519-zebra-2.2.0
	either-1.6.1
	encoding_rs-0.8.30
	enum-as-inner-0.3.4
	event-listener-2.5.2
	fastrand-1.7.0
	fern-0.6.0
	fern-logger-0.5.0
	fixed-hash-0.7.0
	fixedbitset-0.2.0
	fixedbitset-0.4.1
	flate2-1.0.22
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fs2-0.4.3
	funty-1.1.0
	futures-0.3.21
	futures-channel-0.3.21
	futures-core-0.3.21
	futures-executor-0.3.21
	futures-io-0.3.21
	futures-macro-0.3.21
	futures-sink-0.3.21
	futures-task-0.3.21
	futures-timer-3.0.2
	futures-util-0.3.21
	fxhash-0.2.1
	generic-array-0.14.5
	getrandom-0.1.16
	getrandom-0.2.5
	ghash-0.4.4
	glob-0.3.0
	h2-0.3.12
	half-1.8.2
	hash32-0.2.1
	hashbrown-0.11.2
	hashbrown-0.12.0
	headers-0.3.7
	headers-core-0.2.0
	heck-0.3.3
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	hmac-0.8.1
	hmac-drbg-0.3.0
	hostname-0.3.1
	http-0.2.6
	http-body-0.4.4
	httparse-1.6.0
	httpdate-1.0.2
	hyper-0.14.17
	hyper-tls-0.5.0
	idna-0.2.3
	if-addrs-0.6.7
	if-addrs-sys-0.3.2
	impl-codec-0.5.1
	impl-serde-0.3.2
	impl-trait-for-tuples-0.2.2
	indexmap-1.8.0
	instant-0.1.12
	iota-crypto-0.9.2
	ipconfig-0.2.2
	ipnet-2.4.0
	iterator-sorted-0.1.0
	itertools-0.10.3
	itoa-0.4.8
	itoa-1.0.1
	jobserver-0.1.24
	js-sys-0.3.56
	jsonwebtoken-7.2.0
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.120
	libloading-0.7.3
	libp2p-0.41.2
	libp2p-core-0.30.2
	libp2p-dns-0.30.0
	libp2p-identify-0.32.1
	libp2p-metrics-0.2.0
	libp2p-mplex-0.30.0
	libp2p-noise-0.33.0
	libp2p-swarm-0.32.0
	libp2p-swarm-derive-0.26.1
	libp2p-tcp-0.30.0
	libp2p-yamux-0.34.0
	librocksdb-sys-0.6.1+6.28.2
	libsecp256k1-0.7.0
	libsecp256k1-core-0.3.0
	libsecp256k1-gen-ecmult-0.3.0
	libsecp256k1-gen-genmult-0.3.0
	libz-sys-1.1.5
	linked-hash-map-0.5.4
	lock_api-0.4.6
	log-0.4.14
	lru-0.7.3
	lru-cache-0.1.2
	match_cfg-0.1.0
	matches-0.1.9
	memchr-2.4.1
	memoffset-0.6.5
	mime-0.3.16
	mime_guess-2.0.4
	minimal-lexical-0.2.1
	miniz_oxide-0.4.4
	mio-0.8.2
	miow-0.3.7
	multiaddr-0.13.0
	multihash-0.14.0
	multihash-derive-0.7.2
	multimap-0.8.3
	multipart-0.18.0
	multistream-select-0.10.4
	native-tls-0.2.8
	nohash-hasher-0.2.0
	nom-7.1.1
	ntapi-0.3.7
	num-0.4.0
	num-bigint-0.2.6
	num-complex-0.4.0
	num-derive-0.3.3
	num-integer-0.1.44
	num-iter-0.1.42
	num-rational-0.4.0
	num-traits-0.2.14
	num_cpus-1.13.1
	num_threads-0.1.5
	once_cell-1.10.0
	oorandom-11.1.3
	opaque-debug-0.3.0
	open-metrics-client-0.12.0
	open-metrics-client-derive-text-encode-0.1.1
	openssl-0.10.38
	openssl-probe-0.1.5
	openssl-sys-0.9.72
	owning_ref-0.4.1
	packable-0.3.1
	packable-derive-0.3.1
	parity-scale-codec-2.3.1
	parity-scale-codec-derive-2.3.1
	parking_lot-0.11.2
	parking_lot-0.12.0
	parking_lot_core-0.8.5
	parking_lot_core-0.9.1
	peeking_take_while-0.1.2
	pem-0.8.3
	pem-rfc7468-0.3.1
	percent-encoding-2.1.0
	pest-2.1.3
	petgraph-0.5.1
	petgraph-0.6.0
	pin-project-0.4.29
	pin-project-1.0.10
	pin-project-internal-0.4.29
	pin-project-internal-1.0.10
	pin-project-lite-0.2.8
	pin-utils-0.1.0
	pkcs8-0.8.0
	pkg-config-0.3.24
	plotters-0.3.1
	plotters-backend-0.3.2
	plotters-svg-0.3.1
	poly1305-0.7.2
	polyval-0.5.3
	ppv-lite86-0.2.16
	prefix-hex-0.2.0
	primitive-types-0.10.1
	priority-queue-1.2.1
	proc-macro-crate-1.1.3
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	prost-0.8.0
	prost-0.9.0
	prost-build-0.8.0
	prost-build-0.9.0
	prost-derive-0.8.0
	prost-derive-0.9.0
	prost-types-0.8.0
	prost-types-0.9.0
	quick-error-1.2.3
	quote-1.0.16
	radium-0.6.2
	rand-0.7.3
	rand-0.8.5
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.11
	redox_users-0.4.2
	ref-cast-1.0.6
	ref-cast-impl-1.0.6
	regex-1.5.5
	regex-automata-0.1.10
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	reqwest-0.11.10
	resolv-conf-0.7.0
	ring-0.16.20
	rocksdb-0.18.0
	rpassword-5.0.1
	rust-argon2-0.8.3
	rust-embed-6.3.0
	rust-embed-impl-6.2.0
	rust-embed-utils-7.1.0
	rustc-hash-1.1.0
	rustc-hex-2.1.0
	rustc_version-0.3.3
	rustc_version-0.4.0
	rw-stream-sink-0.2.1
	ryu-1.0.9
	safemem-0.3.3
	same-file-1.0.6
	schannel-0.1.19
	scoped-tls-1.0.0
	scopeguard-1.1.0
	security-framework-2.6.1
	security-framework-sys-2.6.1
	semver-0.11.0
	semver-1.0.6
	semver-parser-0.10.2
	serde-1.0.136
	serde-big-array-0.3.2
	serde_cbor-0.11.2
	serde_derive-1.0.136
	serde_json-1.0.79
	serde_repr-0.1.7
	serde_urlencoded-0.7.1
	serial_test-0.5.1
	serial_test_derive-0.5.1
	sha-1-0.9.8
	sha-1-0.10.0
	sha2-0.9.9
	shellexpand-2.1.0
	shlex-1.1.0
	signal-hook-registry-1.4.0
	signature-1.5.0
	simple_asn1-0.4.1
	slab-0.4.5
	sled-0.34.7
	smallvec-1.8.0
	snow-0.8.0
	socket2-0.3.19
	socket2-0.4.4
	spin-0.5.2
	spki-0.5.4
	stable_deref_trait-1.2.0
	static_assertions-1.1.0
	structopt-0.3.26
	structopt-derive-0.4.18
	subtle-2.4.1
	syn-1.0.89
	synstructure-0.12.6
	tap-1.0.1
	tempfile-3.3.0
	textwrap-0.11.0
	thiserror-1.0.30
	thiserror-impl-1.0.30
	time-0.1.43
	time-0.3.7
	time-helper-0.1.0
	tinytemplate-1.2.1
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	tokio-1.17.0
	tokio-macros-1.7.0
	tokio-native-tls-0.3.0
	tokio-stream-0.1.8
	tokio-tungstenite-0.15.0
	tokio-util-0.6.9
	toml-0.5.8
	tower-service-0.3.1
	tracing-0.1.32
	tracing-core-0.1.23
	trust-dns-proto-0.20.4
	trust-dns-resolver-0.20.4
	try-lock-0.2.3
	tungstenite-0.14.0
	twoway-0.1.8
	twox-hash-1.6.2
	typenum-1.15.0
	ucd-trie-0.1.3
	uint-0.9.3
	unicase-2.6.0
	unicode-bidi-0.3.7
	unicode-normalization-0.1.19
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	universal-hash-0.4.1
	unsigned-varint-0.7.1
	untrusted-0.7.1
	url-2.2.2
	utf-8-0.7.6
	vcpkg-0.2.15
	version_check-0.9.4
	void-1.0.2
	walkdir-2.3.2
	want-0.3.0
	warp-0.3.2
	warp-reverse-proxy-0.4.0
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.79
	wasm-bindgen-backend-0.2.79
	wasm-bindgen-futures-0.4.29
	wasm-bindgen-macro-0.2.79
	wasm-bindgen-macro-support-0.2.79
	wasm-bindgen-shared-0.2.79
	web-sys-0.3.56
	which-4.2.4
	widestring-0.4.3
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.32.0
	windows_aarch64_msvc-0.32.0
	windows_i686_gnu-0.32.0
	windows_i686_msvc-0.32.0
	windows_x86_64_gnu-0.32.0
	windows_x86_64_msvc-0.32.0
	winreg-0.6.2
	winreg-0.10.1
	wyz-0.2.0
	x25519-dalek-1.2.0
	yamux-0.9.0
	zeroize-1.3.0
	zeroize_derive-1.3.2
	zip-0.5.13
	zstd-0.9.2+zstd.1.5.1
	zstd-safe-4.1.3+zstd.1.5.1
	zstd-sys-1.6.2+zstd.1.5.1
"
DASHBOARD_VERSION="2.0.0-alpha7"
LLVM_MAX_SLOT=14
MYPV="${PV/_alpha/-alpha.}"
QA_FLAGS_IGNORED="usr/bin/bee"

inherit cargo llvm

DESCRIPTION="IOTA node written in rust"
HOMEPAGE="https://github.com/iotaledger/bee"
SRC_URI="
	dashboard? ( https://github.com/iotaledger/node-dashboard/releases/download/v${DASHBOARD_VERSION}/node-dashboard-bee-${DASHBOARD_VERSION}.zip -> node-dashboard-bee-${DASHBOARD_VERSION} )

	https://github.com/iotaledger/bee/archive/refs/tags/v${MYPV}.tar.gz -> bee-${MYPV}.tar.gz
	$(cargo_crate_uris)
"
S="${WORKDIR}/bee-${MYPV}"

# TODO: find out licenses from the bundled dashboard
LICENSE="
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( BSD-2 MIT )
	|| ( BSD MIT )
	|| ( LGPL-3 MPL-2.0 )
	|| ( MIT Unlicense )
	0BSD
	Apache-2.0
	BSD
	BSD-2
	CC0-1.0
	ISC
	MIT
	MPL-2.0
	openssl
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dashboard +rocksdb sled"

DEPEND="
	<sys-devel/clang-${LLVM_MAX_SLOT}:=
	|| (
		( sys-devel/llvm:14 sys-devel/clang:14 )
		( sys-devel/llvm:13 sys-devel/clang:13 )
		( sys-devel/llvm:12 sys-devel/clang:12 )
	)
"
RDEPEND="
	${DEPEND}
	dashboard? ( net-libs/nodejs )
"
BDEPEND="dev-vcs/git"

PATCHES=( "${FILESDIR}/${P}-no-download.patch" )

llvm_check_deps() {
	has_version -r "sys-devel/clang:${LLVM_SLOT}"
}

pkg_setup() {
	llvm_pkg_setup
}

src_unpack() {
	cargo_src_unpack
	if use dashboard; then
		cp "${DISTDIR}/node-dashboard-bee-${DASHBOARD_VERSION}" "${S}/${PN}/bee-plugin/bee-plugin-dashboard/node-dashboard-bee-${DASHBOARD_VERSION}.zip" || die
	fi
}

src_configure() {
	pushd "${S}/${PN}/${PN}" || die
	local myfeatures=(
		$(usev dashboard)
		$(usev rocksdb)
		$(usev sled)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	pushd "${S}/${PN}/${PN}" || die
	LIBCLANG_PATH="$(get_llvm_prefix)/$(get_libdir)" cargo_src_compile
}

src_install() {
	pushd "${S}/${PN}/${PN}" || die
	cargo_src_install
	insinto "/etc/${PN}"
	doins config*.toml
}
