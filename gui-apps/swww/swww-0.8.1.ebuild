# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.7.6
	aho-corasick@1.0.2
	anes@0.1.6
	anstream@0.3.2
	anstyle@1.0.1
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	assert_cmd@2.0.11
	autocfg@1.1.0
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.3.3
	bitvec@1.0.1
	bstr@1.6.0
	bumpalo@3.13.0
	bytecheck@0.6.11
	bytecheck_derive@0.6.11
	bytemuck@1.13.1
	byteorder@1.4.3
	cast@0.3.0
	cc@1.0.79
	cfg-if@1.0.0
	ciborium@0.2.1
	ciborium-io@0.2.1
	ciborium-ll@0.2.1
	clap@4.3.11
	clap_builder@4.3.11
	clap_complete@4.3.2
	clap_derive@4.3.2
	clap_lex@0.5.0
	color_quant@1.1.0
	colorchoice@1.0.0
	crc32fast@1.3.2
	criterion@0.5.1
	criterion-plot@0.5.0
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	difflib@0.4.0
	dlib@0.5.2
	doc-comment@0.3.3
	downcast-rs@1.2.0
	either@1.8.1
	errno@0.3.1
	errno-dragonfly@0.1.2
	exr@1.7.0
	fast_image_resize@2.7.3
	fdeflate@0.3.0
	flate2@1.0.26
	flume@0.10.14
	funty@2.0.0
	futures-core@0.3.28
	futures-sink@0.3.28
	getrandom@0.2.10
	gif@0.12.0
	half@1.8.2
	half@2.2.1
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.3.2
	image@0.24.6
	io-lifetimes@1.0.11
	is-terminal@0.4.9
	itertools@0.10.5
	itoa@1.0.8
	jobserver@0.1.26
	jpeg-decoder@0.3.0
	js-sys@0.3.64
	keyframe@1.1.1
	lazy_static@1.4.0
	lebe@0.5.2
	libc@0.2.147
	libloading@0.8.0
	libm@0.2.7
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.3
	lock_api@0.4.10
	log@0.4.19
	lzzzz@1.0.4
	memchr@2.5.0
	memmap2@0.5.10
	memoffset@0.7.1
	memoffset@0.9.0
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mint@0.5.9
	nanorand@0.7.0
	nix@0.26.2
	nom@7.1.3
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.15
	num_cpus@1.16.0
	num_threads@0.1.6
	once_cell@1.18.0
	oorandom@11.1.3
	pin-project@1.1.2
	pin-project-internal@1.1.2
	pkg-config@0.3.27
	plotters@0.3.5
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	png@0.17.9
	ppv-lite86@0.2.17
	predicates@3.0.3
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.64
	ptr_meta@0.1.4
	ptr_meta_derive@0.1.4
	qoi@0.4.1
	quick-xml@0.28.2
	quote@1.0.29
	radium@0.7.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon@1.7.0
	rayon-core@1.11.0
	regex@1.9.1
	regex-automata@0.3.3
	regex-syntax@0.7.4
	rend@0.4.0
	rkyv@0.7.42
	rkyv_derive@0.7.42
	rustix@0.37.23
	rustix@0.38.4
	ryu@1.0.14
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.1.0
	sd-notify@0.4.1
	seahash@4.1.0
	serde@1.0.171
	serde_derive@1.0.171
	serde_json@1.0.102
	simd-adler32@0.3.5
	simdutf8@0.1.4
	simplelog@0.12.1
	smallvec@1.11.0
	smithay-client-toolkit@0.17.0
	spin@0.9.8
	static_assertions@1.1.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.25
	tap@1.0.1
	termcolor@1.1.3
	terminal_size@0.2.6
	termtree@0.4.1
	thiserror@1.0.43
	thiserror-impl@1.0.43
	tiff@0.8.1
	time@0.3.23
	time-core@0.1.1
	time-macros@0.2.10
	tinytemplate@1.2.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unicode-ident@1.0.10
	utf8parse@0.2.1
	uuid@1.4.0
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.3.3
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.87
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-shared@0.2.87
	wayland-backend@0.1.2
	wayland-client@0.30.2
	wayland-cursor@0.30.0
	wayland-protocols@0.30.0
	wayland-protocols-wlr@0.1.0
	wayland-scanner@0.30.1
	wayland-sys@0.30.1
	web-sys@0.3.64
	weezl@0.1.7
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-targets@0.48.1
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
	wyz@0.5.1
	xcursor@0.3.4
	zune-inflate@0.2.54
"

inherit cargo shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/LGFae/swww"
SRC_URI="https://github.com/LGFae/swww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz ${CARGO_CRATE_URIS}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
IUSE="+man"
KEYWORDS="~amd64"

DEPEND="
	app-arch/lz4
	x11-libs/libxkbcommon[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="
	>=virtual/rust-1.70.0
	man? ( app-text/scdoc )
"

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
