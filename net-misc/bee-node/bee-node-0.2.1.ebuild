# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BEE_COMMIT="c5d78007500e638c8b0cd7993fd9319da570f0c2"
CONSOLE_COMMIT="3d80c4b68b97db9c20cb496a2e3df0ccc1336b38"
CRATES="
	adler-1.0.2
	aead-0.4.3
	aes-0.7.5
	aes-gcm-0.9.4
	ahash-0.7.4
	ansi_term-0.12.1
	anyhow-1.0.44
	anymap-0.12.1
	arrayref-0.3.6
	arrayvec-0.5.2
	asn1_der-0.7.4
	async-channel-1.6.1
	async-priority-queue-0.1.1
	async-stream-0.3.2
	async-stream-impl-0.3.2
	async-trait-0.1.51
	asynchronous-codec-0.6.0
	atomic-0.5.0
	atty-0.2.14
	autocfg-1.0.1
	base64-0.12.3
	base64-0.13.0
	bech32-0.8.1
	bindgen-0.59.1
	bitflags-1.3.2
	bitvec-0.19.5
	blake2-0.9.2
	blake2b_simd-0.5.11
	block-buffer-0.9.0
	bs58-0.4.0
	buf_redux-0.8.4
	bumpalo-3.7.0
	bytemuck-1.7.2
	byteorder-1.4.3
	bytes-1.1.0
	cache-padded-1.1.1
	cap-0.1.0
	cc-1.0.70
	cexpr-0.5.0
	cfg-if-1.0.0
	chacha20-0.7.3
	chacha20poly1305-0.8.2
	chrono-0.4.19
	cipher-0.3.0
	clang-sys-1.2.2
	clap-2.33.3
	cmake-0.1.45
	colored-1.9.3
	concurrent-queue-1.2.2
	constant_time_eq-0.1.5
	core-foundation-0.9.1
	core-foundation-sys-0.8.2
	cpufeatures-0.2.1
	crc32fast-1.2.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.5
	crunchy-0.2.2
	crypto-mac-0.8.0
	ctr-0.8.0
	curve25519-dalek-3.2.0
	dashmap-4.0.2
	data-encoding-2.3.2
	digest-0.9.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	ed25519-1.2.0
	ed25519-dalek-1.0.1
	ed25519-zebra-2.2.0
	either-1.6.1
	encoding_rs-0.8.28
	enum-as-inner-0.3.3
	event-listener-2.5.1
	fern-0.6.0
	fixedbitset-0.2.0
	flate2-1.0.22
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fs2-0.4.3
	funty-1.1.0
	futures-0.3.17
	futures-channel-0.3.17
	futures-core-0.3.17
	futures-executor-0.3.17
	futures-io-0.3.17
	futures-macro-0.3.17
	futures-sink-0.3.17
	futures-task-0.3.17
	futures-timer-3.0.2
	futures-util-0.3.17
	fxhash-0.2.1
	generic-array-0.14.4
	getrandom-0.1.16
	getrandom-0.2.3
	ghash-0.4.4
	glob-0.3.0
	h2-0.3.4
	hashbrown-0.11.2
	hdrhistogram-7.3.0
	headers-0.3.4
	headers-core-0.2.0
	heck-0.3.3
	hermit-abi-0.1.19
	hex-0.4.3
	hmac-0.8.1
	hmac-drbg-0.3.0
	hostname-0.3.1
	http-0.2.4
	http-body-0.4.3
	httparse-1.5.1
	httpdate-1.0.1
	humantime-2.1.0
	hyper-0.14.12
	hyper-timeout-0.4.1
	hyper-tls-0.5.0
	idna-0.2.3
	if-addrs-0.6.6
	if-addrs-sys-0.3.2
	indexmap-1.7.0
	input_buffer-0.4.0
	instant-0.1.10
	iota-crypto-0.7.0
	ipconfig-0.2.2
	ipnet-2.3.1
	itertools-0.10.1
	itoa-0.4.8
	jobserver-0.1.24
	js-sys-0.3.54
	jsonwebtoken-7.2.0
	lazy_static-1.4.0
	lazycell-1.3.0
	lexical-core-0.7.6
	libc-0.2.101
	libloading-0.7.0
	libp2p-0.39.1
	libp2p-core-0.29.0
	libp2p-dns-0.29.0
	libp2p-identify-0.30.0
	libp2p-mplex-0.29.0
	libp2p-noise-0.32.0
	libp2p-swarm-0.30.0
	libp2p-swarm-derive-0.24.0
	libp2p-tcp-0.29.0
	libp2p-yamux-0.33.0
	librocksdb-sys-6.20.3
	libsecp256k1-0.5.0
	libsecp256k1-core-0.2.2
	libsecp256k1-gen-ecmult-0.2.1
	libsecp256k1-gen-genmult-0.2.1
	linked-hash-map-0.5.4
	lock_api-0.4.5
	log-0.4.14
	lru-0.6.6
	lru-cache-0.1.2
	match_cfg-0.1.0
	matchers-0.0.1
	matches-0.1.9
	memchr-2.3.4
	memoffset-0.6.4
	mime-0.3.16
	mime_guess-2.0.3
	miniz_oxide-0.4.4
	mio-0.7.13
	miow-0.3.7
	multiaddr-0.13.0
	multihash-0.14.0
	multihash-derive-0.7.2
	multimap-0.8.3
	multipart-0.17.1
	multistream-select-0.10.2
	native-tls-0.2.8
	nohash-hasher-0.2.0
	nom-6.2.1
	ntapi-0.3.6
	num-bigint-0.2.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	opaque-debug-0.3.0
	openssl-0.10.36
	openssl-probe-0.1.4
	openssl-sys-0.9.66
	paho-mqtt-0.9.1
	paho-mqtt-sys-0.5.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	peeking_take_while-0.1.2
	pem-0.8.3
	percent-encoding-2.1.0
	pest-2.1.3
	petgraph-0.5.1
	pin-project-0.4.28
	pin-project-1.0.8
	pin-project-internal-0.4.28
	pin-project-internal-1.0.8
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.19
	poly1305-0.7.2
	polyval-0.5.3
	ppv-lite86-0.2.10
	proc-macro-crate-1.0.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.29
	prost-0.8.0
	prost-build-0.8.0
	prost-derive-0.8.0
	prost-types-0.8.0
	quick-error-1.2.3
	quote-1.0.9
	radium-0.5.3
	rand-0.7.3
	rand-0.8.4
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_hc-0.3.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	ref-cast-1.0.6
	ref-cast-impl-1.0.6
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	reqwest-0.11.4
	resolv-conf-0.7.0
	ring-0.16.20
	rocksdb-0.17.0
	rpassword-5.0.1
	rust-argon2-0.8.3
	rust-embed-6.2.0
	rust-embed-impl-6.1.0
	rust-embed-utils-7.0.0
	rustc-hash-1.1.0
	rustc_version-0.3.3
	rw-stream-sink-0.2.1
	ryu-1.0.5
	safemem-0.3.3
	same-file-1.0.6
	schannel-0.1.19
	scoped-tls-1.0.0
	scopeguard-1.1.0
	security-framework-2.4.2
	security-framework-sys-2.4.2
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.67
	serde_repr-0.1.7
	serde_urlencoded-0.7.0
	sha-1-0.9.8
	sha2-0.9.8
	sharded-slab-0.1.3
	shellexpand-2.1.0
	shlex-1.1.0
	signal-hook-registry-1.4.0
	signature-1.3.1
	simple_asn1-0.4.1
	slab-0.4.4
	sled-0.34.7
	smallvec-1.6.1
	snow-0.8.0
	socket2-0.3.19
	socket2-0.4.1
	spin-0.5.2
	spin-0.9.2
	static_assertions-1.1.0
	structopt-0.3.23
	structopt-derive-0.4.16
	subtle-2.4.1
	syn-1.0.76
	synstructure-0.12.5
	tap-1.0.1
	tempfile-3.2.0
	textwrap-0.11.0
	thiserror-1.0.29
	thiserror-impl-1.0.29
	thread_local-1.1.3
	time-0.1.43
	tiny-keccak-2.0.2
	tinyvec-1.4.0
	tinyvec_macros-0.1.0
	tokio-1.11.0
	tokio-io-timeout-1.1.1
	tokio-macros-1.3.0
	tokio-native-tls-0.3.0
	tokio-stream-0.1.7
	tokio-tungstenite-0.13.0
	tokio-util-0.6.8
	toml-0.5.8
	tonic-0.5.2
	tonic-build-0.5.2
	tower-0.4.8
	tower-layer-0.3.1
	tower-service-0.3.1
	tracing-0.1.27
	tracing-attributes-0.1.16
	tracing-core-0.1.20
	tracing-futures-0.2.5
	tracing-log-0.1.2
	tracing-serde-0.1.2
	tracing-subscriber-0.2.22
	trust-dns-proto-0.20.3
	trust-dns-resolver-0.20.3
	try-lock-0.2.3
	tungstenite-0.12.0
	twoway-0.1.8
	twox-hash-1.6.1
	typenum-1.14.0
	ucd-trie-0.1.3
	unicase-2.6.0
	unicode-bidi-0.3.6
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	universal-hash-0.4.1
	unsigned-varint-0.7.0
	untrusted-0.7.1
	url-2.2.2
	utf-8-0.7.6
	vcpkg-0.2.15
	version_check-0.9.3
	void-1.0.2
	walkdir-2.3.2
	want-0.3.0
	warp-0.3.1
	warp-reverse-proxy-0.3.2
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.77
	wasm-bindgen-backend-0.2.77
	wasm-bindgen-futures-0.4.27
	wasm-bindgen-macro-0.2.77
	wasm-bindgen-macro-support-0.2.77
	wasm-bindgen-shared-0.2.77
	wasm-timer-0.2.5
	web-sys-0.3.54
	which-4.2.2
	widestring-0.4.3
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.6.2
	winreg-0.7.0
	wyz-0.2.0
	x25519-dalek-1.1.1
	yamux-0.9.0
	zeroize-1.3.0
	zeroize_derive-1.1.0
	zstd-0.9.0+zstd.1.5.0
	zstd-safe-4.1.1+zstd.1.5.0
	zstd-sys-1.6.1+zstd.1.5.0
"
LLVM_MAX_SLOT=12
QA_FLAGS_IGNORED="usr/bin/bee"

inherit cargo llvm

DESCRIPTION="IOTA node written in rust"
HOMEPAGE="https://github.com/iotaledger/bee"
SRC_URI="
	https://github.com/iotaledger/bee/archive/refs/tags/v${PV}.tar.gz -> bee.tar.gz
	https://github.com/iotaledger/bee/archive/${BEE_COMMIT}.tar.gz -> bee-${BEE_COMMIT}.tar.gz
	https://github.com/tokio-rs/console/archive/${CONSOLE_COMMIT}.tar.gz -> tokio-rs-console-${CONSOLE_COMMIT}.tar.gz
	$(cargo_crate_uris)
"
S="${WORKDIR}/bee-${PV}/${PN}"

LICENSE="
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( BSD-2 MIT )
	|| ( BSD MIT )
	|| ( MIT Unlicense )
	0BSD
	Apache-2.0
	BSD
	BSD-2
	CC0-1.0
	EPL-1.0
	ISC
	MIT
	MPL-2.0
	openssl
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<sys-devel/clang-${LLVM_MAX_SLOT}:=
	|| (
		( sys-devel/llvm:11 sys-devel/clang:11 )
		( sys-devel/llvm:12 sys-devel/clang:12 )
	)
"
DEPEND=${RDEPEND}

llvm_check_deps() {
	has_version -r "sys-devel/clang:${LLVM_SLOT}"
}

pkg_setup() {
	llvm_pkg_setup
}

src_prepare() {
	pushd ../../ || die
	mv "bee-${BEE_COMMIT}" "bee" || die
	mv "console-${CONSOLE_COMMIT}" "console" || die
	popd || die

	pushd ../ || die
	eapply "${FILESDIR}/${P}-bundle-crates.patch"
	popd || die

	default
}

src_compile() {
	LIBCLANG_PATH="$(get_llvm_prefix)/$(get_libdir)" cargo_src_compile
}

src_install() {
	cargo_src_install
	insinto "/etc/${PN}"
	doins config*.toml
}
