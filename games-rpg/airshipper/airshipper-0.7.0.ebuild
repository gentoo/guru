# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ab_glyph-0.2.11
	ab_glyph_rasterizer-0.1.4
	addr2line-0.16.0
	adler-1.0.2
	adler32-1.2.0
	ahash-0.4.7
	aho-corasick-0.7.18
	andrew-0.3.1
	ansi_term-0.12.1
	approx-0.5.0
	arc-swap-1.5.0
	arrayvec-0.7.1
	ash-0.33.1+1.2.186
	async-stream-0.3.2
	async-stream-impl-0.3.2
	async-trait-0.1.50
	atom_syndication-0.9.1
	atomic-0.5.0
	atty-0.2.14
	autocfg-1.0.1
	backtrace-0.3.61
	base-x-0.2.8
	base64-0.12.3
	base64-0.13.0
	binascii-0.1.4
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.2.1
	block-0.1.6
	bstr-0.2.16
	bumpalo-2.6.0
	bumpalo-3.7.0
	bytemuck-1.7.0
	bytemuck_derive-1.0.1
	byteorder-1.4.3
	bytes-1.0.1
	bytesize-1.0.1
	bzip2-0.4.3
	bzip2-sys-0.1.11+1.0.8
	calloop-0.6.5
	cc-1.0.68
	cfg-if-0.1.10
	cfg-if-1.0.0
	cfg_aliases-0.1.1
	chrono-0.4.19
	clap-3.0.0-beta.2
	clap_derive-3.0.0-beta.2
	clipboard-win-4.2.1
	clipboard_macos-0.1.0
	clipboard_wayland-0.2.0
	clipboard_x11-0.3.1
	cocoa-0.24.0
	cocoa-foundation-0.1.0
	codespan-reporting-0.11.1
	color_quant-1.1.0
	colored-1.9.3
	colored-2.0.0
	console-0.14.1
	const_fn-0.4.8
	convert_case-0.4.0
	cookie-0.15.1
	copyless-0.1.5
	core-foundation-0.7.0
	core-foundation-0.9.1
	core-foundation-sys-0.7.0
	core-foundation-sys-0.8.2
	core-graphics-0.19.2
	core-graphics-0.22.2
	core-graphics-types-0.1.1
	core-video-sys-0.1.4
	crc32fast-1.2.1
	crossbeam-0.8.1
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.0
	crossbeam-epoch-0.9.5
	crossbeam-queue-0.3.2
	crossbeam-utils-0.8.5
	d3d12-0.4.1
	darling-0.10.2
	darling_core-0.10.2
	darling_macro-0.10.2
	deflate-0.8.6
	derivative-2.2.0
	derive_builder-0.9.0
	derive_builder_core-0.9.0
	derive_more-0.99.16
	devise-0.3.0
	devise_codegen-0.3.0
	devise_core-0.3.0
	diesel-1.4.7
	diesel_derives-1.4.1
	diesel_migrations-1.4.0
	diligent-date-parser-0.1.2
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	discard-1.0.4
	dispatch-0.2.0
	dlib-0.4.2
	dlib-0.5.0
	doc-comment-0.3.3
	dodrio-0.2.0
	dotenv-0.15.0
	downcast-rs-1.2.0
	either-1.6.1
	encode_unicode-0.3.6
	encoding_rs-0.8.28
	error-code-2.3.0
	euclid-0.22.6
	fern-0.6.0
	figment-0.10.6
	find_folder-0.3.0
	fixedbitset-0.4.0
	flate2-1.0.20
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	futf-0.1.4
	futures-0.3.15
	futures-channel-0.3.15
	futures-core-0.3.15
	futures-executor-0.3.15
	futures-io-0.3.15
	futures-macro-0.3.15
	futures-sink-0.3.15
	futures-task-0.3.15
	futures-util-0.3.15
	fxhash-0.2.1
	generator-0.7.0
	gethostname-0.2.1
	getopts-0.2.21
	getrandom-0.1.16
	getrandom-0.2.3
	gif-0.11.2
	gimli-0.25.0
	glam-0.10.2
	glob-0.3.0
	glow-0.11.0
	glyph_brush-0.7.2
	glyph_brush_draw_cache-0.1.4
	glyph_brush_layout-0.2.2
	gpu-alloc-0.5.0
	gpu-alloc-types-0.2.0
	gpu-descriptor-0.2.1
	gpu-descriptor-types-0.1.1
	guillotiere-0.6.1
	h2-0.3.3
	hashbrown-0.9.1
	hashbrown-0.11.2
	heck-0.3.3
	hermit-abi-0.1.19
	html2text-0.2.1
	html5ever-0.25.1
	http-0.2.4
	http-body-0.4.2
	httparse-1.4.1
	httpdate-1.0.1
	hyper-0.14.10
	hyper-rustls-0.22.1
	hyper-tls-0.5.0
	hyperx-1.4.0
	ident_case-1.0.1
	idna-0.2.3
	image-0.23.14
	indexmap-1.7.0
	indicatif-0.15.0
	indicatif-0.16.2
	inlinable_string-0.1.14
	inplace_it-0.3.3
	instant-0.1.9
	ipnet-2.3.1
	itoa-0.4.7
	jni-sys-0.3.0
	jpeg-decoder-0.1.22
	js-sys-0.3.53
	jsonwebtoken-7.2.0
	khronos-egl-4.1.0
	language-tags-0.3.2
	lazy_static-1.4.0
	libc-0.2.98
	libloading-0.6.7
	libloading-0.7.0
	libsqlite3-sys-0.20.1
	linked-hash-map-0.5.4
	lock_api-0.4.4
	log-0.4.14
	longest-increasing-subsequence-0.1.0
	loom-0.5.1
	mac-0.1.1
	malloc_buf-0.0.6
	markup5ever-0.10.1
	markup5ever_rcdom-0.1.0
	matchers-0.0.1
	matches-0.1.8
	maybe-uninit-2.0.0
	md5-0.7.0
	memchr-2.4.0
	memmap2-0.1.0
	memmap2-0.2.3
	memoffset-0.6.4
	metal-0.23.1
	migrations_internals-1.4.1
	migrations_macros-1.4.2
	mime-0.3.16
	miniz_oxide-0.3.7
	miniz_oxide-0.4.4
	mio-0.7.13
	mio-misc-1.2.1
	miow-0.3.7
	multer-2.0.0
	naga-0.6.1
	native-tls-0.2.7
	ndk-0.3.0
	ndk-glue-0.3.0
	ndk-macro-0.2.0
	ndk-sys-0.2.1
	new_debug_unreachable-1.0.4
	nix-0.18.0
	nix-0.20.0
	nom-6.1.2
	ntapi-0.3.6
	num-bigint-0.2.6
	num-integer-0.1.44
	num-iter-0.1.42
	num-rational-0.3.2
	num-traits-0.2.14
	num_cpus-1.13.0
	num_enum-0.5.4
	num_enum_derive-0.5.4
	number_prefix-0.3.0
	number_prefix-0.4.0
	objc-0.2.7
	objc-foundation-0.1.1
	objc_exception-0.1.2
	objc_id-0.1.1
	object-0.26.0
	once_cell-1.8.0
	opener-0.5.0
	openssl-0.10.35
	openssl-probe-0.1.4
	openssl-src-111.15.0+1.1.1k
	openssl-sys-0.9.65
	ordered-float-2.6.0
	os_str_bytes-2.4.0
	owned_ttf_parser-0.6.0
	owned_ttf_parser-0.12.1
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	pear-0.2.3
	pear_codegen-0.2.3
	pem-0.8.3
	percent-encoding-2.1.0
	pest-2.1.3
	petgraph-0.6.0
	phf-0.8.0
	phf_codegen-0.8.0
	phf_generator-0.8.0
	phf_shared-0.8.0
	pin-project-1.0.7
	pin-project-internal-1.0.7
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.19
	png-0.16.8
	ppv-lite86-0.2.10
	precomputed-hash-0.1.1
	proc-macro-crate-0.1.5
	proc-macro-crate-1.0.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.27
	proc-macro2-diagnostics-0.9.1
	profiling-1.0.3
	prometheus-0.12.0
	protobuf-2.24.1
	pulldown-cmark-0.7.2
	pulldown-cmark-0.8.0
	quick-xml-0.20.0
	quote-1.0.9
	r2d2-0.8.9
	rand-0.7.3
	rand-0.8.4
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_hc-0.3.1
	rand_pcg-0.2.1
	range-alloc-0.1.2
	raw-window-handle-0.3.3
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.9
	redox_users-0.4.0
	ref-cast-1.0.6
	ref-cast-impl-1.0.6
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	renderdoc-sys-0.7.1
	reqwest-0.11.4
	ring-0.16.20
	ron-0.6.4
	ron-0.7.0
	rss-1.10.0
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	rustc_version-0.2.3
	rustc_version-0.3.3
	rustls-0.19.1
	rusttype-0.9.2
	rustversion-1.0.5
	ryu-1.0.5
	same-file-1.0.6
	schannel-0.1.19
	scheduled-thread-pool-0.2.5
	scoped-tls-1.0.0
	scopeguard-1.1.0
	sct-0.6.1
	security-framework-2.3.1
	security-framework-sys-2.3.0
	self_update-0.27.0
	semver-0.9.0
	semver-0.11.0
	semver-1.0.3
	semver-parser-0.7.0
	semver-parser-0.10.2
	serde-1.0.126
	serde_derive-1.0.126
	serde_json-1.0.64
	serde_path_to_error-0.1.7
	serde_urlencoded-0.7.0
	sha1-0.6.0
	sharded-slab-0.1.1
	signal-hook-registry-1.4.0
	simple_asn1-0.4.1
	siphasher-0.3.5
	slab-0.4.3
	slotmap-1.0.5
	smallvec-1.6.1
	smithay-client-toolkit-0.12.3
	smithay-client-toolkit-0.14.0
	smithay-clipboard-0.6.4
	snafu-0.7.0
	snafu-derive-0.7.0
	socket2-0.4.0
	spin-0.5.2
	spin-0.9.2
	spirv-0.2.0+1.5.4
	stable-pattern-0.1.0
	standback-0.2.17
	state-0.5.2
	static_assertions-1.1.0
	stdweb-0.4.20
	stdweb-derive-0.5.3
	stdweb-internal-macros-0.2.9
	stdweb-internal-runtime-0.1.5
	str-buf-1.0.5
	string_cache-0.8.1
	string_cache_codegen-0.5.1
	strip_markdown-0.2.0
	strsim-0.9.3
	strsim-0.10.0
	svg_fmt-0.4.1
	syn-1.0.73
	tempfile-3.2.0
	tendril-0.4.2
	termcolor-1.1.2
	terminal_size-0.1.17
	textwrap-0.12.1
	thiserror-1.0.26
	thiserror-impl-1.0.26
	thread_local-1.1.3
	time-0.1.43
	time-0.2.27
	time-macros-0.1.1
	time-macros-impl-0.1.2
	tinyvec-1.2.0
	tinyvec_macros-0.1.0
	tokio-1.8.1
	tokio-macros-1.3.0
	tokio-native-tls-0.3.0
	tokio-rustls-0.22.0
	tokio-stream-0.1.7
	tokio-util-0.6.7
	toml-0.5.8
	tower-service-0.3.1
	tracing-0.1.26
	tracing-attributes-0.1.15
	tracing-core-0.1.18
	tracing-futures-0.2.5
	tracing-log-0.1.2
	tracing-serde-0.1.2
	tracing-subscriber-0.2.19
	try-lock-0.2.3
	ttf-parser-0.6.2
	ttf-parser-0.12.3
	twoway-0.2.2
	twox-hash-1.6.0
	ubyte-0.10.1
	ucd-trie-0.1.3
	uncased-0.9.6
	unchecked-index-0.2.2
	unicase-2.6.0
	unicode-bidi-0.3.5
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	untrusted-0.7.1
	url-2.2.2
	utf-8-0.7.6
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.3
	walkdir-2.3.2
	want-0.3.0
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.76
	wasm-bindgen-backend-0.2.76
	wasm-bindgen-futures-0.4.26
	wasm-bindgen-macro-0.2.76
	wasm-bindgen-macro-support-0.2.76
	wasm-bindgen-shared-0.2.76
	wayland-client-0.28.6
	wayland-commons-0.28.6
	wayland-cursor-0.28.6
	wayland-protocols-0.28.6
	wayland-scanner-0.28.6
	wayland-sys-0.28.6
	web-sys-0.3.51
	webpki-0.21.4
	webpki-roots-0.21.1
	weezl-0.1.5
	wgpu-0.10.1
	wgpu-core-0.10.1
	wgpu-hal-0.10.2
	wgpu-types-0.10.0
	wgpu_glyph-0.14.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-wsapoll-0.1.1
	winapi-x86_64-pc-windows-gnu-0.4.0
	window_clipboard-0.2.1
	winreg-0.7.0
	winres-0.1.11
	x11-dl-2.18.5
	x11rb-0.8.1
	xcursor-0.3.3
	xdg-2.2.0
	xi-unicode-0.3.0
	xml-rs-0.8.3
	xml5ever-0.16.1
	yansi-0.5.0
	zip-0.5.13
"

inherit cargo desktop

# From app-emulation/ruffle::gentoo
AIRSHIPPER_GIT=(
	"hecrj iced 2d65621a3b680457e689b93c800e74f726ffc175 iced:.,iced_native:native,iced_winit:winit"
	"iced-rs winit fea65a7f852fb36956adc0b13b6647e25eec33ec winit:."
	"SergioBenitez Rocket 693f4f9ee50057fc735e6e7037e6dee5b485ba10 rocket:core/lib,rocket_sync_db_pools:contrib/sync_db_pools/lib"
	"XAMPPRocky octocrab c78edcd87fa5edcd5a6d0d0878b2a8d020802c40 octocrab:."
)
airshipper_uris() {
	cargo_crate_uris

	local g
	for g in "${AIRSHIPPER_GIT[@]}"; do
		g=(${g})
		echo "https://github.com/${g[0]}/${g[1]}/archive/${g[2]}.tar.gz -> ${g[1]}-${g[2]}.tar.gz"
	done
}

DESCRIPTION="Provides automatic updates for the voxel RPG Veloren"
HOMEPAGE="
	https://veloren.net
	https://gitlab.com/veloren/airshipper
"
SRC_URI="
	https://gitlab.com/veloren/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz
	$(airshipper_uris)
"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="Apache-2.0 BSD BSL-1.1 GPL-3 ISC MIT MPL-2.0 OFL-1.1 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	default

	local crate g
	for g in "${AIRSHIPPER_GIT[@]}"; do
		g=(${g})
		echo "[patch.\"https://github.com/${g[0]}/${g[1]}\"]"
		for crate in ${g[3]//,/ }; do
			echo "${crate%:*} = { path = \"../${g[1]}-${g[2]}/${crate#*:}\" }"
		done
	done >> Cargo.toml || die
}

src_compile() {
	cargo_src_compile --bins
}

src_install() {
	default

	doicon -s 256 client/assets/net.veloren.airshipper.png
	domenu client/assets/net.veloren.airshipper.desktop

	dobin target/release/${PN}
}
