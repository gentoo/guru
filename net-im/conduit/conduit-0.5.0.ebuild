# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	adler32-1.2.0
	ahash-0.7.6
	aho-corasick-0.7.20
	alloc-no-stdlib-2.0.4
	alloc-stdlib-0.2.2
	anes-0.1.6
	anyhow-1.0.68
	arc-swap-1.5.1
	arrayref-0.3.6
	arrayvec-0.7.2
	assert_matches-1.5.0
	assign-1.1.1
	async-channel-1.8.0
	async-compression-0.3.15
	async-stream-0.3.3
	async-stream-impl-0.3.3
	async-trait-0.1.58
	async-trait-0.1.61
	atomic-0.5.1
	atty-0.2.14
	autocfg-1.1.0
	axum-0.5.17
	axum-core-0.2.9
	axum-server-0.4.4
	base-x-0.2.11
	base64-0.13.1
	base64-0.20.0
	base64-0.21.0
	base64ct-1.5.3
	bincode-1.3.3
	bindgen-0.59.2
	bitflags-1.3.2
	blake2b_simd-1.0.0
	block-buffer-0.10.3
	block-buffer-0.9.0
	brotli-3.3.4
	brotli-decompressor-2.3.2
	brotli-decompressor-2.3.4
	bumpalo-3.11.1
	bumpalo-3.12.0
	bytemuck-1.12.3
	byteorder-1.4.3
	bytes-1.3.0
	cast-0.3.0
	castaway-0.1.2
	cc-1.0.77
	cc-1.0.78
	cexpr-0.6.0
	cfg-if-0.1.10
	cfg-if-1.0.0
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clang-sys-1.4.0
	clap-3.1.18
	clap-3.2.23
	clap-4.0.27
	clap-4.1.1
	clap_derive-4.0.21
	clap_derive-4.1.0
	clap_lex-0.2.4
	clap_lex-0.3.0
	clap_lex-0.3.1
	color_quant-1.1.0
	combine-4.6.6
	concurrent-queue-2.1.0
	console_error_panic_hook-0.1.7
	const-oid-0.9.1
	const_fn-0.4.9
	constant_time_eq-0.1.5
	cookie-0.15.2
	cookie_store-0.15.1
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	cpufeatures-0.2.5
	crc-2.1.0
	crc-catalog-1.1.1
	crc32fast-1.3.2
	criterion-0.4.0
	criterion-plot-0.5.0
	crossbeam-0.8.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-queue-0.3.8
	crossbeam-utils-0.8.14
	crypto-common-0.1.6
	curl-0.4.44
	curl-sys-0.4.59+curl-7.86.0
	curve25519-dalek-3.2.0
	dashmap-5.4.0
	data-encoding-2.3.2
	data-encoding-2.3.3
	der-0.6.0
	der-0.6.1
	digest-0.10.6
	digest-0.9.0
	directories-4.0.1
	dirs-sys-0.3.7
	discard-1.0.4
	doc-comment-0.3.3
	ed25519-1.5.2
	ed25519-1.5.3
	ed25519-dalek-1.0.1
	either-1.8.0
	encoding_rs-0.8.31
	enum-as-inner-0.3.4
	enum-as-inner-0.5.1
	env_logger-0.8.4
	errno-0.2.8
	errno-dragonfly-0.1.2
	event-listener-2.5.3
	fallible-iterator-0.2.0
	fallible-streaming-iterator-0.1.9
	fastrand-1.6.0
	fastrand-1.8.0
	figment-0.10.8
	flate2-1.0.25
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.1.0
	fs2-0.4.3
	fs_extra-1.2.0
	futf-0.1.5
	futures-0.3.25
	futures-channel-0.3.25
	futures-core-0.3.25
	futures-executor-0.3.25
	futures-io-0.3.25
	futures-lite-1.12.0
	futures-macro-0.3.25
	futures-sink-0.3.25
	futures-task-0.3.25
	futures-util-0.3.25
	generic-array-0.14.6
	getrandom-0.1.16
	getrandom-0.2.8
	gif-0.11.4
	glob-0.3.0
	glob-0.3.1
	h2-0.3.15
	half-1.8.2
	hashbrown-0.12.3
	hashlink-0.8.1
	headers-0.3.8
	headers-core-0.2.0
	heck-0.4.0
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hmac-0.12.1
	hostname-0.3.1
	html5ever-0.25.2
	http-0.2.8
	http-body-0.4.5
	http-range-header-0.3.0
	httparse-1.8.0
	httpdate-1.0.2
	humantime-2.1.0
	hyper-0.14.23
	hyper-rustls-0.23.1
	hyper-rustls-0.23.2
	hyper-tls-0.5.0
	idna-0.2.3
	idna-0.3.0
	image-0.24.5
	indexmap-1.9.2
	inlinable_string-0.1.15
	instant-0.1.12
	integer-encoding-3.0.4
	io-lifetimes-1.0.4
	ipconfig-0.2.2
	ipconfig-0.3.1
	ipnet-2.5.1
	ipnet-2.7.1
	is-terminal-0.4.2
	isahc-1.3.1
	isahc-1.7.2
	itertools-0.10.5
	itoa-1.0.4
	itoa-1.0.5
	jobserver-0.1.25
	jpeg-decoder-0.3.0
	js-sys-0.3.60
	js_int-0.2.2
	js_option-0.1.1
	jsonwebtoken-8.1.1
	konst-0.2.19
	konst_macro_rules-0.2.19
	konst_proc_macros-0.2.11
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.137
	libc-0.2.139
	libflate-1.2.0
	libflate_lz77-1.1.0
	libloading-0.7.4
	libnghttp2-sys-0.1.7+1.45.0
	librocksdb-sys-6.20.3
	libsqlite3-sys-0.25.2
	libz-sys-1.1.8
	linked-hash-map-0.5.6
	linux-raw-sys-0.1.4
	lmdb-rkv-sys-0.11.2
	lock_api-0.4.9
	log-0.4.17
	lru-cache-0.1.2
	mac-0.1.1
	maplit-1.0.2
	markup5ever-0.10.1
	match_cfg-0.1.0
	matchers-0.1.0
	matches-0.1.9
	matchit-0.5.0
	memchr-2.5.0
	memoffset-0.7.1
	mime-0.3.16
	mime_guess-2.0.4
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	mio-0.8.5
	native-tls-0.2.11
	native-tls-0.2.8
	new_debug_unreachable-1.0.4
	nom-7.1.1
	nu-ansi-term-0.46.0
	num-bigint-0.4.3
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.14.0
	num_cpus-1.15.0
	once_cell-1.16.0
	once_cell-1.17.0
	oorandom-11.1.3
	opaque-debug-0.3.0
	openssl-0.10.29
	openssl-0.10.45
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-src-111.24.0+1.1.1s
	openssl-sys-0.9.55
	openssl-sys-0.9.80
	opentelemetry-0.18.0
	opentelemetry-jaeger-0.17.0
	opentelemetry-semantic-conventions-0.10.0
	opentelemetry_api-0.18.0
	opentelemetry_sdk-0.18.0
	ordered-float-1.1.1
	os_str_bytes-6.4.1
	overload-0.1.1
	page_size-0.4.2
	parking-2.0.0
	parking_lot-0.11.2
	parking_lot-0.12.1
	parking_lot_core-0.8.6
	parking_lot_core-0.9.4
	parking_lot_core-0.9.6
	paste-1.0.9
	pear-0.2.3
	pear_codegen-0.2.3
	peeking_take_while-0.1.2
	pem-1.1.0
	percent-encoding-2.2.0
	persy-1.3.4
	phf-0.10.1
	phf-0.8.0
	phf_codegen-0.8.0
	phf_generator-0.10.0
	phf_generator-0.8.0
	phf_macros-0.10.0
	phf_shared-0.10.0
	phf_shared-0.8.0
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkcs8-0.9.0
	pkg-config-0.3.26
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	png-0.17.7
	polling-2.5.2
	ppv-lite86-0.2.17
	precomputed-hash-0.1.1
	proc-macro-crate-1.2.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro-hack-0.5.20+deprecated
	proc-macro-hack-0.5.4
	proc-macro2-1.0.47
	proc-macro2-1.0.50
	proc-macro2-diagnostics-0.9.1
	psl-types-2.0.11
	publicsuffix-2.2.3
	pulldown-cmark-0.9.2
	quick-error-1.2.3
	quote-1.0.21
	quote-1.0.23
	rand-0.7.3
	rand-0.8.5
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.4
	rand_hc-0.2.0
	rand_pcg-0.2.1
	rayon-1.3.1
	rayon-1.6.1
	rayon-core-1.10.1
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.5.6
	regex-1.7.0
	regex-1.7.1
	regex-automata-0.1.10
	regex-syntax-0.6.28
	remove_dir_all-0.5.0
	remove_dir_all-0.5.3
	resolv-conf-0.7.0
	ring-0.16.20
	rle-decode-fast-1.0.3
	rocksdb-0.17.0
	rusqlite-0.28.0
	rust-argon2-1.0.0
	rustc-hash-1.1.0
	rustc_version-0.2.3
	rustix-0.36.6
	rustls-0.20.7
	rustls-0.20.8
	rustls-native-certs-0.6.2
	rustls-pemfile-0.2.1
	rustls-pemfile-1.0.1
	rustls-pemfile-1.0.2
	ryu-1.0.11
	ryu-1.0.12
	same-file-1.0.6
	schannel-0.1.20
	schannel-0.1.21
	scoped-tls-1.0.1
	scopeguard-1.1.0
	sct-0.7.0
	sd-notify-0.4.1
	security-framework-2.7.0
	security-framework-sys-2.6.1
	semver-0.9.0
	semver-1.0.16
	semver-parser-0.7.0
	serde-1.0.147
	serde-1.0.152
	serde_derive-1.0.147
	serde_derive-1.0.152
	serde_json-1.0.87
	serde_json-1.0.89
	serde_json-1.0.91
	serde_urlencoded-0.7.1
	serde_yaml-0.9.14
	serde_yaml-0.9.16
	sha-1-0.10.0
	sha1-0.10.5
	sha1-0.6.1
	sha1_smol-1.0.0
	sha2-0.9.9
	sharded-slab-0.1.4
	shlex-1.1.0
	signal-hook-registry-1.4.0
	signature-1.6.4
	simple_asn1-0.6.2
	siphasher-0.3.10
	slab-0.4.7
	sluice-0.5.5
	smallvec-1.10.0
	smol-1.2.5
	socket2-0.3.19
	socket2-0.4.7
	spin-0.5.2
	spki-0.6.0
	standback-0.2.17
	stdweb-0.4.20
	stdweb-derive-0.5.3
	stdweb-internal-macros-0.2.9
	stdweb-internal-runtime-0.1.5
	string_cache-0.8.4
	string_cache_codegen-0.5.2
	strsim-0.10.0
	subslice-0.2.3
	subtle-2.4.1
	syn-1.0.103
	syn-1.0.107
	sync_wrapper-0.1.1
	synchronoise-1.0.1
	synstructure-0.12.6
	tempfile-3.3.0
	tendril-0.4.3
	termcolor-1.0.4
	termcolor-1.2.0
	textwrap-0.16.0
	thiserror-1.0.37
	thiserror-1.0.38
	thiserror-impl-1.0.37
	thiserror-impl-1.0.38
	thread_local-1.1.4
	threadpool-1.8.1
	thrift-0.16.0
	tikv-jemalloc-ctl-0.5.0
	tikv-jemalloc-sys-0.5.2+5.3.0-patched
	tikv-jemallocator-0.5.0
	time-0.2.27
	time-0.3.17
	time-core-0.1.0
	time-macros-0.1.1
	time-macros-0.2.6
	time-macros-impl-0.1.2
	tinytemplate-1.1.0
	tinytemplate-1.2.1
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tokio-1.22.0
	tokio-1.24.2
	tokio-macros-1.8.0
	tokio-macros-1.8.2
	tokio-native-tls-0.3.0
	tokio-rustls-0.23.4
	tokio-socks-0.5.1
	tokio-stream-0.1.11
	tokio-util-0.6.10
	tokio-util-0.7.4
	toml-0.5.10
	toml-0.5.9
	toml_datetime-0.5.0
	toml_edit-0.15.0
	tower-0.4.13
	tower-http-0.3.4
	tower-layer-0.3.2
	tower-service-0.3.2
	tracing-0.1.37
	tracing-attributes-0.1.23
	tracing-core-0.1.30
	tracing-flame-0.2.0
	tracing-futures-0.2.5
	tracing-log-0.1.3
	tracing-opentelemetry-0.18.0
	tracing-subscriber-0.3.16
	trust-dns-proto-0.20.4
	trust-dns-proto-0.22.0
	trust-dns-resolver-0.20.4
	trust-dns-resolver-0.22.0
	try-lock-0.2.3
	try-lock-0.2.4
	trybuild-1.0.76
	typenum-1.15.0
	typenum-1.16.0
	uncased-0.9.7
	unicase-2.6.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.5
	unicode-ident-1.0.6
	unicode-normalization-0.1.22
	unicode-xid-0.2.4
	unsafe-libyaml-0.2.4
	unsafe-libyaml-0.2.5
	unsigned-varint-0.7.1
	untrusted-0.7.1
	url-2.3.1
	utf-8-0.7.6
	uuid-1.2.2
	valuable-0.1.0
	vcpkg-0.2.15
	version_check-0.9.4
	waker-fn-1.0.0
	waker-fn-1.1.0
	walkdir-2.3.2
	want-0.3.0
	wasi-0.11.0+wasi-snapshot-preview1
	wasi-0.9.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-futures-0.4.33
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	wasm-bindgen-test-0.3.33
	wasm-bindgen-test-macro-0.3.33
	web-sys-0.3.60
	webpki-0.22.0
	webpki-roots-0.22.6
	weezl-0.1.7
	wepoll-ffi-0.1.2
	widestring-0.4.3
	widestring-0.5.1
	wildmatch-2.1.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.36.1
	windows_aarch64_msvc-0.42.0
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.36.1
	windows_i686_gnu-0.42.0
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.36.1
	windows_i686_msvc-0.42.0
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.36.1
	windows_x86_64_msvc-0.42.0
	windows_x86_64_msvc-0.42.1
	winreg-0.10.1
	winreg-0.6.2
	winreg-0.7.0
	xshell-0.1.17
	xshell-macros-0.1.17
	yansi-0.5.1
	yap-0.8.1
	zeroize-1.5.7
	zeroize_derive-1.3.2
	zeroize_derive-1.3.3
	zigzag-0.1.0
"

inherit cargo systemd

# As of 0.5.0, Conduit uses specific commits of these
# crates so they need to be added to SRC_URI manually
CONDUITCOMMIT="53f14a2c4c216b529cc63137d8704573197aed19"
RUMACOMMIT="67d0f3cc04a8d1dc4a8a1ec947519967ce11ce26"
REQCOMMIT="57b7cf4feb921573dfafad7d34b9ac6e44ead0bd"
HEEDCOMMIT="f6f825da7fb2c758867e05ad973ef800a6fe1d5d"

DESCRIPTION="A Matrix homeserver written in Rust"
HOMEPAGE="https://gitlab.com/famedly/conduit"
SRC_URI="https://gitlab.com/famedly/${PN}/-/archive/v${PV}/${P}.tar.bz2
	https://github.com/ruma/ruma/archive/${RUMACOMMIT}.tar.gz -> ruma-${RUMACOMMIT}.crate
	https://github.com/timokoesters/reqwest/archive/${REQCOMMIT}.tar.gz -> reqwest-${REQCOMMIT}.crate
	https://github.com/timokoesters/heed/archive/${HEEDCOMMIT}.tar.gz -> heed-${HEEDCOMMIT}.crate
	$(cargo_crate_uris)
"

S="${WORKDIR}/${PN}-v${PV}-${CONDUITCOMMIT}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="acct-user/conduit"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/clang"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	cargo_src_unpack

	# Conduit uses custom forks/commits for Heed, Reqwest and Ruma
	# The Heed and Ruma crates can't be used by portage as-is,
	# so they need to be unpacked and corrected manually

	# Prepare Ruma Crates
	cd "${WORKDIR}/cargo_home/gentoo/ruma-${RUMACOMMIT}/crates" || die

	# Remove references to workspaces since we are moving them out of the ruma workspace
	sed -i -e '/workspace/d' "ruma/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-appservice-api/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-client-api/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-client/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-common/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-federation-api/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-identifiers-validation/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-identity-service-api/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-macros/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-push-gateway-api/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-server-util/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-signatures/Cargo.toml" || die
	sed -i -e '/workspace/d' "ruma-state-res/Cargo.toml" || die

	# Because we undid the workspaces, some of the packages unpacked from
	# the ruma crate are missing dependencies, so we add them back here

	RUMADEPS="\[dependencies\]"
	RUMADEPS+="\nassign = \"1.1.1\""
	RUMADEPS+="\njs_int = { version = \"0.2.2\", features = \[\"serde\"\] }"
	sed -i -e "s/^\[dependencies\]$/${RUMADEPS}/" "ruma/Cargo.toml" || die

	RUMEAPPSERVICEDEPS="\[dependencies\]"
	RUMEAPPSERVICEDEPS+="\njs_int = { version = \"0.2.2\", features = \[\"serde\"\] }"
	RUMEAPPSERVICEDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMEAPPSERVICEDEPS+="\nserde_json = { version = \"1.0.87\", features = \[\"raw_value\"\] }"
	sed -i -e "s/^\[dependencies\]$/${RUMEAPPSERVICEDEPS}/" "ruma-appservice-api/Cargo.toml" || die

	RUMACLIENTDEPS="\[dependencies\]"
	RUMACLIENTDEPS+="\nassign = \"1.1.1\""
	RUMACLIENTDEPS+="\nhttp = \"0.2.8\""
	RUMACLIENTDEPS+="\njs_int = { version = \"0.2.2\", features = \[\"serde\"\] }"
	RUMACLIENTDEPS+="\nmaplit = \"1.0.2\""
	RUMACLIENTDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMACLIENTDEPS+="\nserde_json = \"1.0.87\""
	sed -i -e "s/^\[dependencies\]$/${RUMACLIENTDEPS}/" "ruma-client-api/Cargo.toml" || die

	RUMACOMMONDEPS="\[dependencies\]"
	RUMACOMMONDEPS+="\nbase64 = \"0.20.0\""
	RUMACOMMONDEPS+="\nhttp = { version = \"0.2.8\", optional = true }"
	RUMACOMMONDEPS+="\njs_int = { version = \"0.2.2\", features = \[\"serde\"\] }"
	RUMACOMMONDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMACOMMONDEPS+="\nserde_json = { version = \"1.0.87\", features = \[\"raw_value\"\] }"
	RUMACOMMONDEPS+="\nthiserror = \"1.0.37\""
	RUMACOMMONDEPS+="\ntracing = { version = \"0.1.37\", features = \[\"attributes\"\] }"
	sed -i -e "s/^\[dependencies\]$/${RUMACOMMONDEPS}/" "ruma-common/Cargo.toml" || die

	RUMAIDENTIFIERSDEPS="\[dependencies\]"
	RUMAIDENTIFIERSDEPS+="\njs_int = \"0.2.2\""
	RUMAIDENTIFIERSDEPS+="\nthiserror = \"1.0.37\""
	sed -i -e "s/^\[dependencies\]$/${RUMAIDENTIFIERSDEPS}/" "ruma-identifiers-validation/Cargo.toml" || die

	RUMAFEDERATIONDEPS="\[dependencies\]"
	RUMAFEDERATIONDEPS+="\njs_int = { version = \"0.2.2\", features = \[\"serde\"\] }"
	RUMAFEDERATIONDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMAFEDERATIONDEPS+="\nserde_json = \"1.0.87\""
	sed -i -e "s/^\[dependencies\]$/${RUMAFEDERATIONDEPS}/" "ruma-federation-api/Cargo.toml" || die

	RUMAMACROSDEPS="\[dependencies\]"
	RUMAMACROSDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	sed -i -e "s/^\[dependencies\]$/${RUMAMACROSDEPS}/" "ruma-macros/Cargo.toml" || die

	RUMAPUSHDEPS="\[dependencies\]"
	RUMAPUSHDEPS+="\njs_int = { version = \"0.2.2\", features = \[\"serde\"\] }"
	RUMAPUSHDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMAPUSHDEPS+="\nserde_json = \"1.0.87\""
	sed -i -e "s/^\[dependencies\]$/${RUMAPUSHDEPS}/" "ruma-push-gateway-api/Cargo.toml" || die

	RUMASIGNDEPS="\[dependencies\]"
	RUMASIGNDEPS+="\nbase64 = \"0.20.0\""
	RUMASIGNDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMASIGNDEPS+="\nserde_json = { version = \"1.0.87\", features = \[\"raw_value\"\] }"
	RUMASIGNDEPS+="\nthiserror = \"1.0.37\""
	sed -i -e "s/^\[dependencies\]$/${RUMASIGNDEPS}/" "ruma-signatures/Cargo.toml" || die

	RUMASTATEDEPS="\[dependencies\]"
	RUMASTATEDEPS+="\njs_int = \"0.2.2\""
	RUMASTATEDEPS+="\nserde = { version = \"1.0.147\", features = \[\"derive\"\] }"
	RUMASTATEDEPS+="\nserde_json = \"1.0.87\""
	RUMASTATEDEPS+="\nthiserror = \"1.0.37\""
	RUMASTATEDEPS+="\ntracing = { version = \"0.1.37\", features = \[\"std\"\] }"
	sed -i -e "s/^\[dependencies\]$/${RUMASTATEDEPS}/" "ruma-state-res/Cargo.toml" || die

	# Copy the checksum so Cargo is happy
	cp "../.cargo-checksum.json" "ruma" || die
	cp "../.cargo-checksum.json" "ruma-appservice-api" || die
	cp "../.cargo-checksum.json" "ruma-client" || die
	cp "../.cargo-checksum.json" "ruma-client-api" || die
	cp "../.cargo-checksum.json" "ruma-common" || die
	cp "../.cargo-checksum.json" "ruma-federation-api" || die
	cp "../.cargo-checksum.json" "ruma-identifiers-validation" || die
	cp "../.cargo-checksum.json" "ruma-identity-service-api" || die
	cp "../.cargo-checksum.json" "ruma-macros" || die
	cp "../.cargo-checksum.json" "ruma-push-gateway-api" || die
	cp "../.cargo-checksum.json" "ruma-server-util" || die
	cp "../.cargo-checksum.json" "ruma-signatures" || die
	cp "../.cargo-checksum.json" "ruma-state-res" || die

	# Move them in cargo home
	mv "ruma" "../../ruma-0.7.4" || die
	mv "ruma-appservice-api" "../../ruma-appservice-api-0.7.0" || die
	mv "ruma-client" "../../ruma-client-0.10.0" || die
	mv "ruma-client-api" "../../ruma-client-api-0.15.3" || die
	mv "ruma-common" "../../ruma-common-0.10.5" || die
	mv "ruma-federation-api" "../../ruma-federation-api-0.6.0" || die
	mv "ruma-identifiers-validation" "../../ruma-identifiers-validation-0.9.0" || die
	mv "ruma-identity-service-api" "../../ruma-identity-service-api-0.6.0" || die
	mv "ruma-macros" "../../ruma-macros-0.10.5" || die
	mv "ruma-push-gateway-api" "../../ruma-push-gateway-api-0.6.0" || die
	mv "ruma-server-util" "../../ruma-server-util-0.1.0" || die
	mv "ruma-signatures" "../../ruma-signatures-0.12.0" || die
	mv "ruma-state-res" "../../ruma-state-res-0.8.0" || die

	# Repeat all of the above for xtask
	cd "${WORKDIR}/cargo_home/gentoo/ruma-${RUMACOMMIT}" || die
	sed -i -e '/workspace/d' "xtask/Cargo.toml" || die
	cp ".cargo-checksum.json" "xtask" || die
	mv "xtask" "../xtask-0.1.0" || die

	# Remove the now useless Cargo.toml
	rm "Cargo.toml" || die

	# Repeat all of the above for heed
	cd "${WORKDIR}/cargo_home/gentoo/heed-${HEEDCOMMIT}" || die
	cp ".cargo-checksum.json" "heed" || die
	cp ".cargo-checksum.json" "heed-traits" || die
	cp ".cargo-checksum.json" "heed-types" || die
	mv "heed" "../heed-0.10.6" || die
	mv "heed-traits" "../heed-traits-0.7.0" || die
	mv "heed-types" "../heed-types-0.7.2" || die
	rm "Cargo.toml" || die

	# We also need to update Conduit's dependencies to let Cargo know
	# that they are available in the local store and don't need to be
	# fetched from their git repositoes
	cd "${S}" || die
	sed -i -e 's/^heed.*/heed = \{ version = "0.10.6", optional = true \}/' Cargo.toml || die
	REQWESTFEATURES="features = "
	REQWESTFEATURES+="\[\"rustls-tls-native-roots\", \"socks\"\]"
	sed -i -e "s/^reqwest.*/reqwest = { version = \"0.11.9\", ${REQWESTFEATURES} }/" Cargo.toml || die
	RUMAFEATURES="features = \["
	RUMAFEATURES+="\"compat\", "
	RUMAFEATURES+="\"rand\", "
	RUMAFEATURES+="\"appservice-api-c\", "
	RUMAFEATURES+="\"client-api\", "
	RUMAFEATURES+="\"federation-api\", "
	RUMAFEATURES+="\"push-gateway-api-c\", "
	RUMAFEATURES+="\"state-res\", "
	RUMAFEATURES+="\"unstable-msc2448\", "
	RUMAFEATURES+="\"unstable-exhaustive-types\", "
	RUMAFEATURES+="\"ring-compat\", "
	RUMAFEATURES+="\"unstable-unspecified\""
	RUMAFEATURES+="\]"
	sed -i -e "s/^ruma.*/ruma = { version = \"0.7.4\", ${RUMAFEATURES} }/" Cargo.toml || die
}

src_install() {
	cargo_src_install

	keepdir "/var/lib/matrix-conduit"
	fowners conduit:conduit "/var/lib/matrix-conduit"
	fperms 700 "/var/lib/matrix-conduit"

	insinto "/etc/conduit"
	doins "${FILESDIR}/conduit.toml"
	newinitd "${FILESDIR}/conduit.initd" "conduit"
	newconfd "${FILESDIR}/conduit.confd" "conduit"
	systemd_dounit "${FILESDIR}/conduit.service"
}
