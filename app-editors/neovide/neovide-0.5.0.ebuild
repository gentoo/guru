# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler32-1.0.4
	ahash-0.2.18
	aho-corasick-0.7.8
	ansi_term-0.11.0
	anyhow-1.0.26
	arc-swap-0.4.4
	arrayref-0.3.6
	arrayvec-0.4.12
	arrayvec-0.5.1
	ash-0.29.0
	async-trait-0.1.24
	atty-0.2.14
	autocfg-0.1.7
	autocfg-1.0.0
	base64-0.11.0
	bindgen-0.52.0
	bitflags-1.2.1
	blake2b_simd-0.5.10
	block-0.1.6
	byteorder-1.3.4
	bytes-0.4.12
	bytes-0.5.4
	cc-1.0.50
	cexpr-0.3.6
	cfg-if-0.1.10
	chrono-0.4.10
	clang-sys-0.28.1
	clap-2.33.0
	cloudabi-0.0.3
	cmake-0.1.42
	cocoa-0.19.1
	color_quant-1.0.1
	const-random-0.1.8
	const-random-macro-0.1.8
	constant_time_eq-0.1.5
	core-foundation-0.6.4
	core-foundation-0.7.0
	core-foundation-sys-0.6.2
	core-foundation-sys-0.7.0
	core-graphics-0.17.3
	core-graphics-0.19.0
	core-text-13.3.2
	core-text-15.0.0
	crc32fast-1.2.0
	crossbeam-deque-0.7.3
	crossbeam-epoch-0.8.2
	crossbeam-queue-0.2.1
	crossbeam-utils-0.7.2
	curl-0.4.25
	curl-sys-0.4.26
	deflate-0.7.20
	derive-new-0.5.8
	dirs-2.0.2
	dirs-sys-0.3.4
	dwrote-0.9.0
	either-1.5.3
	encoding_rs-0.8.22
	env_logger-0.7.1
	euclid-0.20.7
	expat-sys-2.1.6
	filetime-0.2.8
	flate2-1.0.13
	flexi_logger-0.14.8
	float-ord-0.2.0
	fnv-1.0.6
	font-kit-0.5.0
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	freetype-0.4.1
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	futures-0.1.29
	futures-0.3.4
	futures-channel-0.3.4
	futures-core-0.3.4
	futures-executor-0.3.4
	futures-io-0.3.4
	futures-macro-0.3.4
	futures-sink-0.3.4
	futures-task-0.3.4
	futures-util-0.3.4
	getrandom-0.1.14
	gif-0.10.3
	glob-0.3.0
	harfbuzz-0.3.1
	harfbuzz-sys-0.3.4
	hashbrown-0.6.3
	heck-0.3.1
	hermit-abi-0.1.8
	humantime-1.3.0
	image-0.22.5
	inflate-0.4.5
	iovec-0.1.4
	itoa-0.4.5
	jpeg-decoder-0.1.18
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	lazycell-1.2.1
	libc-0.2.67
	libloading-0.5.2
	libz-sys-1.0.25
	lock_api-0.3.3
	log-0.4.8
	lru-0.4.3
	lyon_geom-0.14.1
	lyon_path-0.14.0
	lzw-0.10.0
	malloc_buf-0.0.6
	maybe-uninit-2.0.0
	memchr-2.3.3
	memoffset-0.5.3
	metal-0.17.1
	miniz_oxide-0.3.6
	mio-0.6.21
	mio-named-pipes-0.1.6
	mio-uds-0.6.7
	miow-0.2.1
	miow-0.3.3
	net2-0.2.33
	nodrop-0.1.14
	nom-4.2.3
	num-derive-0.2.5
	num-integer-0.1.42
	num-iter-0.1.40
	num-rational-0.2.3
	num-traits-0.2.11
	num_cpus-1.12.0
	objc-0.2.7
	objc_exception-0.1.2
	openssl-probe-0.1.2
	openssl-sys-0.9.54
	parking_lot-0.10.0
	parking_lot_core-0.7.0
	peeking_take_while-0.1.2
	pin-project-0.4.8
	pin-project-internal-0.4.8
	pin-project-lite-0.1.4
	pin-utils-0.1.0-alpha.4
	pkg-config-0.3.17
	png-0.15.3
	proc-macro-hack-0.5.11
	proc-macro-nested-0.1.3
	proc-macro2-0.4.30
	proc-macro2-1.0.9
	quick-error-1.2.3
	quote-0.6.13
	quote-1.0.2
	raw-window-handle-0.3.3
	rayon-1.3.0
	rayon-core-1.7.0
	redox_syscall-0.1.56
	redox_users-0.3.4
	regex-1.3.4
	regex-syntax-0.6.14
	rmp-0.8.9
	rmpv-0.4.4
	rust-argon2-0.7.0
	rust-embed-5.5.0
	rust-embed-impl-5.5.0
	rust-embed-utils-5.0.0
	rustc-hash-1.1.0
	rustc_version-0.2.3
	ryu-1.0.2
	same-file-1.0.6
	schannel-0.1.17
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	semver-0.9.0
	semver-parser-0.7.0
	serde-1.0.104
	serde_json-1.0.48
	servo-fontconfig-0.4.0
	servo-fontconfig-sys-4.0.9
	servo-freetype-sys-4.0.5
	shared_library-0.1.9
	shlex-0.1.1
	signal-hook-registry-1.2.0
	skia-bindings-0.26.1
	skia-safe-0.26.1
	slab-0.4.2
	smallvec-1.2.0
	socket2-0.3.11
	strsim-0.8.0
	syn-0.15.44
	syn-1.0.16
	tar-0.4.26
	termcolor-1.1.0
	textwrap-0.11.0
	thread_local-1.0.1
	tiff-0.3.1
	time-0.1.42
	tokio-0.2.11
	tokio-io-0.1.13
	tokio-macros-0.2.4
	toml-0.5.6
	unicode-normalization-0.1.12
	unicode-segmentation-1.6.0
	unicode-width-0.1.7
	unicode-xid-0.1.0
	unicode-xid-0.2.0
	unidiff-0.3.2
	vcpkg-0.2.8
	vec_map-0.8.1
	version_check-0.1.5
	walkdir-2.3.1
	wasi-0.9.0+wasi-snapshot-preview1
	which-3.1.0
	winapi-0.2.8
	winapi-0.3.8
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.3
	winapi-x86_64-pc-windows-gnu-0.4.0
	winres-0.1.11
	ws2_32-sys-0.2.1
	xattr-0.2.2
"

inherit cargo desktop flag-o-matic

DESCRIPTION="A simple GUI for Neovim."
HOMEPAGE="https://github.com/neovide/neovide"
SRC_URI="
	https://github.com/neovide/neovide/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 FTL GPL-2 ISC LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DEPEND="
	media-libs/fontconfig:=
	media-libs/freetype:2[harfbuzz,utils]
	app-editors/neovim
	media-libs/mesa[vulkan]
	media-libs/libglvnd
	x11-misc/shared-mime-info
	media-libs/libglvnd
	media-sound/sndio
"

RDEPEND="
	${DEPEND}
	!app-editors/neovide
"

BDEPEND="
	${DEPEND}
	dev-util/cmake
	dev-lang/rust
	media-libs/libsdl2
	sys-devel/make
	dev-vcs/git
"

QA_FLAGS_IGNORED="usr/bin/.*"


src_prepare () {
	cd neovide || die
	sed -i 's/debug = true/opt-level = 3\ndebug = false/' Cargo.toml
}

src_compile () {
	append-cflags $(test-flags-CC -fcommon -fPIE)
	cargo_src_compile
}

src_install () {
	domenu "$FILESDIR"/neovide.desktop
	doicon "$FILESDIR"/neovide.png
	dobin target/release/neovide
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	einfo "Troubleshooting"
	echo || die 
	einfo "set guifont=Your\ Font\ Name:h15  in init.vim file."
	einfo "* Install additional packages for optional runtime features:
	 *   x11-misc/xsel for clipboard support
	 *   x11-misc/xclip for clipboard support
	 *   gui-apps/wl-clipboard for clipboard support
	 *   dev-python/pynvim for Python plugin support
	 *   dev-ruby/neovim-ruby-client for Ruby plugin support
	 *   dev-python/neovim-remote for remote/nvr support
	"
}
