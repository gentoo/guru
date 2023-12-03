# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	anes-0.1.6
	anstream-0.2.6
	anstyle-0.3.5
	anstyle-parse-0.1.1
	anstyle-wincon-0.2.0
	assert_cmd-2.0.10
	atty-0.2.14
	autocfg-1.1.0
	bincode-1.3.3
	bit_field-0.10.2
	bitflags-1.3.2
	bstr-1.4.0
	bumpalo-3.12.0
	bytemuck-1.13.1
	byteorder-1.4.3
	calloop-0.10.5
	cast-0.3.0
	cc-1.0.79
	cfg-if-1.0.0
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clap-3.2.23
	clap-4.2.1
	clap_builder-4.2.1
	clap_complete-4.2.0
	clap_derive-4.2.0
	clap_lex-0.2.4
	clap_lex-0.4.1
	color_quant-1.1.0
	concolor-override-1.0.0
	concolor-query-0.3.3
	crc32fast-1.3.2
	criterion-0.4.0
	criterion-plot-0.5.0
	crossbeam-channel-0.5.8
	crossbeam-deque-0.8.3
	crossbeam-epoch-0.9.14
	crossbeam-utils-0.8.15
	crunchy-0.2.2
	difflib-0.4.0
	dlib-0.5.0
	doc-comment-0.3.3
	downcast-rs-1.2.0
	either-1.8.1
	errno-0.3.1
	errno-dragonfly-0.1.2
	exr-1.6.3
	fast_image_resize-2.7.0
	fdeflate-0.3.0
	flate2-1.0.25
	flume-0.10.14
	futures-core-0.3.28
	futures-sink-0.3.28
	getrandom-0.2.9
	gif-0.12.0
	half-1.8.2
	half-2.2.1
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	image-0.24.6
	indexmap-1.9.3
	io-lifetimes-1.0.10
	is-terminal-0.4.7
	itertools-0.10.5
	itoa-1.0.6
	jobserver-0.1.26
	jpeg-decoder-0.3.0
	js-sys-0.3.61
	keyframe-1.1.1
	lazy_static-1.4.0
	lebe-0.5.2
	libc-0.2.141
	libloading-0.7.4
	libm-0.2.6
	linux-raw-sys-0.3.1
	lock_api-0.4.9
	log-0.4.17
	lzzzz-1.0.4
	memchr-2.5.0
	memmap2-0.5.10
	memoffset-0.6.5
	memoffset-0.8.0
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	miniz_oxide-0.7.1
	mint-0.5.9
	nanorand-0.7.0
	nix-0.24.3
	nix-0.25.1
	nom-7.1.3
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.15.0
	num_threads-0.1.6
	once_cell-1.17.1
	oorandom-11.1.3
	os_str_bytes-6.5.0
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pkg-config-0.3.26
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	png-0.17.8
	ppv-lite86-0.2.17
	predicates-3.0.2
	predicates-core-1.0.6
	predicates-tree-1.0.9
	proc-macro2-1.0.56
	qoi-0.4.1
	quote-1.0.26
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rayon-1.7.0
	rayon-core-1.11.0
	regex-1.7.3
	regex-automata-0.1.10
	regex-syntax-0.6.29
	rustix-0.37.11
	ryu-1.0.13
	same-file-1.0.6
	scopeguard-1.1.0
	sd-notify-0.4.1
	serde-1.0.160
	serde_derive-1.0.160
	serde_json-1.0.96
	simd-adler32-0.3.5
	simplelog-0.12.1
	slotmap-1.0.6
	smallvec-1.10.0
	smithay-client-toolkit-0.16.0
	spin-0.9.8
	strsim-0.10.0
	syn-1.0.109
	syn-2.0.14
	termcolor-1.1.3
	terminal_size-0.2.6
	termtree-0.4.1
	textwrap-0.16.0
	thiserror-1.0.40
	thiserror-impl-1.0.40
	tiff-0.8.1
	time-0.3.20
	time-core-0.1.0
	time-macros-0.2.8
	tinytemplate-1.2.1
	unicode-ident-1.0.8
	utf8parse-0.2.1
	vec_map-0.8.2
	version_check-0.9.4
	wait-timeout-0.2.0
	walkdir-2.3.3
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.84
	wasm-bindgen-backend-0.2.84
	wasm-bindgen-macro-0.2.84
	wasm-bindgen-macro-support-0.2.84
	wasm-bindgen-shared-0.2.84
	wayland-client-0.29.5
	wayland-commons-0.29.5
	wayland-cursor-0.29.5
	wayland-protocols-0.29.5
	wayland-scanner-0.29.5
	wayland-sys-0.29.5
	web-sys-0.3.61
	weezl-0.1.7
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.45.0
	windows-sys-0.48.0
	windows-targets-0.42.2
	windows-targets-0.48.0
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_gnullvm-0.48.0
	windows_aarch64_msvc-0.42.2
	windows_aarch64_msvc-0.48.0
	windows_i686_gnu-0.42.2
	windows_i686_gnu-0.48.0
	windows_i686_msvc-0.42.2
	windows_i686_msvc-0.48.0
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnu-0.48.0
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_gnullvm-0.48.0
	windows_x86_64_msvc-0.42.2
	windows_x86_64_msvc-0.48.0
	xcursor-0.3.4
	xml-rs-0.8.4
	zune-inflate-0.2.53
"

inherit cargo shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/Horus645/swww"
SRC_URI="https://github.com/Horus645/swww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz ${CARGO_CRATE_URIS}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
IUSE="+man"
KEYWORDS="~amd64"

DEPEND="app-arch/lz4
	x11-libs/libxkbcommon[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="app-text/scdoc"

QA_FLAGS_IGNORED="
	usr/bin/swww
	usr/bin/swww-daemon
"

src_install() {
	dodoc README.md CHANGELOG.md
	dobashcomp "${WORKDIR}/swww-${PV}/completions/swww.bash"
	dofishcomp "${WORKDIR}/swww-${PV}/completions/swww.fish"

	if use man ; then
		cd "${WORKDIR}/swww-${PV}/doc/" || die
		./gen.sh || die #generate the man pages
		doman "generated/swww.1"
		doman "generated/swww-clear.1"
		doman "generated/swww-daemon.1"
		doman "generated/swww-img.1"
		doman "generated/swww-init.1"
		doman "generated/swww-kill.1"
		doman "generated/swww-query.1"
	fi

	if use debug ; then
		cd "${WORKDIR}/swww-${PV}/target/debug" || die
	else
		cd "${WORKDIR}/swww-${PV}/target/release"  || die
	fi

	dobin swww{,-daemon}
}
