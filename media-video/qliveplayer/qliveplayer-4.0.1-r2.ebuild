# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	adler-1.0.2
	aho-corasick-0.7.18
	async-compression-0.3.8
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	bincode-1.3.3
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.3.1
	block-buffer-0.9.0
	bumpalo-3.7.0
	byteorder-1.4.3
	bytes-0.4.12
	bytes-1.0.1
	cc-1.0.69
	cfg-if-1.0.0
	chrono-0.4.19
	core-foundation-0.9.1
	core-foundation-sys-0.8.2
	cpufeatures-0.1.5
	crc32fast-1.2.1
	digest-0.9.0
	encoding_rs-0.8.28
	env_logger-0.9.0
	fancy-regex-0.7.1
	flate2-1.0.20
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	futures-0.3.16
	futures-channel-0.3.16
	futures-core-0.3.16
	futures-executor-0.3.16
	futures-io-0.3.16
	futures-macro-0.3.16
	futures-sink-0.3.16
	futures-task-0.3.16
	futures-util-0.3.16
	generic-array-0.14.4
	getrandom-0.2.3
	h2-0.3.3
	hashbrown-0.11.2
	hermit-abi-0.1.19
	html-escape-0.2.9
	http-0.2.4
	http-body-0.4.3
	httparse-1.4.1
	httpdate-1.0.1
	humantime-2.1.0
	hyper-0.14.11
	hyper-tls-0.5.0
	idna-0.2.3
	indexmap-1.7.0
	instant-0.1.10
	iovec-0.1.4
	ipnet-2.3.1
	itoa-0.4.7
	js-sys-0.3.52
	lazy_static-1.4.0
	libc-0.2.99
	lock_api-0.4.4
	log-0.4.14
	matches-0.1.9
	memchr-2.4.0
	mime-0.3.16
	miniz_oxide-0.4.4
	mio-0.7.13
	miow-0.3.7
	native-tls-0.2.8
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	opaque-debug-0.3.0
	openssl-0.10.35
	openssl-probe-0.1.4
	openssl-sys-0.9.65
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	percent-encoding-2.1.0
	pin-project-1.0.8
	pin-project-internal-1.0.8
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.19
	ppv-lite86-0.2.10
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.28
	quick-error-1.2.3
	quote-1.0.9
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	redox_syscall-0.2.10
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	reqwest-0.11.4
	ryu-1.0.5
	schannel-0.1.19
	scopeguard-1.1.0
	security-framework-2.3.1
	security-framework-sys-2.3.0
	serde-1.0.127
	serde_derive-1.0.127
	serde_json-1.0.66
	serde_urlencoded-0.7.0
	sha-1-0.9.7
	signal-hook-registry-1.4.0
	slab-0.4.4
	smallvec-1.6.1
	socket2-0.4.1
	syn-1.0.74
	tempfile-3.2.0
	termcolor-1.1.2
	thiserror-1.0.26
	thiserror-impl-1.0.26
	time-0.1.43
	tinyvec-1.3.1
	tinyvec_macros-0.1.0
	tokio-1.10.0
	tokio-macros-1.3.0
	tokio-native-tls-0.3.0
	tokio-tungstenite-0.15.0
	tokio-util-0.6.7
	tower-service-0.3.1
	tracing-0.1.26
	tracing-core-0.1.18
	try-lock-0.2.3
	tungstenite-0.14.0
	typenum-1.13.0
	unicode-bidi-0.3.6
	unicode-normalization-0.1.19
	unicode-xid-0.2.2
	url-2.2.2
	utf-8-0.7.6
	utf8-width-0.1.5
	uuid-0.8.2
	vcpkg-0.2.15
	version_check-0.9.3
	want-0.3.0
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.75
	wasm-bindgen-backend-0.2.75
	wasm-bindgen-futures-0.4.25
	wasm-bindgen-macro-0.2.75
	wasm-bindgen-macro-support-0.2.75
	wasm-bindgen-shared-0.2.75
	web-sys-0.3.52
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.7.0
"
CARGO_OPTIONAL=1

inherit cargo cmake readme.gentoo-r1 xdg

LIB_COMMIT="03d3c7b0bf010986710182ba4ab9a887b4c3b42d"
LIB_P="QLivePlayer-Lib-${LIB_COMMIT}"
MY_P="QLivePlayer-${PV}"

DESCRIPTION="A player and recorder for live streams and videos with danmaku support"
HOMEPAGE="https://github.com/THMonster/QLivePlayer"
SRC_URI="
	https://github.com/THMonster/QLivePlayer/archive/refs/tags/${PV}.tar.gz -> ${MY_P}.tar.gz
	https://github.com/THMonster/QLivePlayer-Lib/archive/${LIB_COMMIT}.tar.gz -> ${LIB_P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
PATCHES=(
	"${FILESDIR}/native-tls-novendor.patch"
)
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"

COMMON_DEPEND="
	>=dev-qt/qtcore-5.15:5
	>=dev-qt/qtdeclarative-5.15:5
	>=dev-qt/qtgui-5.15:5
	>=dev-qt/qtnetwork-5.15:5
	>=dev-qt/qtwidgets-5.15:5
	dev-libs/openssl
"
RDEPEND="
	${COMMON_DEPEND}
	>=dev-qt/qtquickcontrols-5.15:5
	>=dev-qt/qtquickcontrols2-5.15:5
	>=dev-qt/qtsvg-5.15:5
	media-video/ffmpeg
	media-video/mpv
	net-misc/curl
"
DEPEND="
	${COMMON_DEPEND}
	>=dev-qt/qtconcurrent-5.15:5
	kde-frameworks/extra-cmake-modules:5
"
BDEPEND="
	virtual/rust
"

src_unpack() {
	cargo_src_unpack
	rm -rf "${LIB_P}" || die
	tar -C "${MY_P}"/src/QLivePlayer-Lib --strip-components=1 -xzf "${DISTDIR}/${LIB_P}.tar.gz" || die
}

src_prepare() {
	xdg_environment_reset
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	readme.gentoo_print_elog
}
