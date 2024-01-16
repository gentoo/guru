# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.7.7
	aho-corasick@1.1.2
	anes@0.1.6
	anstream@0.6.7
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.4
	assert_cmd@2.0.13
	autocfg@1.1.0
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.4.1
	bitvec@1.0.1
	bstr@1.9.0
	bumpalo@3.14.0
	bytecheck@0.6.11
	bytecheck_derive@0.6.11
	bytemuck@1.14.0
	byteorder@1.5.0
	bytes@1.5.0
	cast@0.3.0
	cc@1.0.83
	cfg-if@1.0.0
	ciborium-io@0.2.1
	ciborium-ll@0.2.1
	ciborium@0.2.1
	clap@4.4.16
	clap_builder@4.4.16
	clap_complete@4.4.6
	clap_derive@4.4.7
	clap_lex@0.6.0
	color_quant@1.1.0
	colorchoice@1.0.0
	crc32fast@1.3.2
	criterion-plot@0.5.0
	criterion@0.5.1
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	cursor-icon@1.1.0
	deranged@0.3.11
	difflib@0.4.0
	dlib@0.5.2
	doc-comment@0.3.3
	downcast-rs@1.2.0
	either@1.9.0
	errno@0.3.8
	exr@1.71.0
	fast_image_resize@2.7.3
	fdeflate@0.3.3
	flate2@1.0.28
	flume@0.11.0
	funty@2.0.0
	getrandom@0.2.12
	gif@0.12.0
	half@1.8.2
	half@2.2.1
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.3.3
	image@0.24.8
	is-terminal@0.4.10
	itertools@0.10.5
	itertools@0.11.0
	itoa@1.0.10
	jobserver@0.1.27
	jpeg-decoder@0.3.1
	js-sys@0.3.67
	keyframe@1.1.1
	lazy_static@1.4.0
	lebe@0.5.2
	libc@0.2.152
	libloading@0.8.1
	libm@0.2.8
	linux-raw-sys@0.4.12
	lock_api@0.4.11
	log@0.4.20
	lzzzz@1.0.4
	memchr@2.7.1
	memmap2@0.9.3
	memoffset@0.7.1
	miniz_oxide@0.7.1
	mint@0.5.9
	nix@0.26.4
	nix@0.27.1
	num-traits@0.2.17
	num_threads@0.1.6
	once_cell@1.19.0
	oorandom@11.1.3
	pkg-config@0.3.28
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	plotters@0.3.5
	png@0.17.11
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@3.0.4
	proc-macro2@1.0.76
	ptr_meta@0.1.4
	ptr_meta_derive@0.1.4
	qoi@0.4.1
	quick-xml@0.30.0
	quote@1.0.35
	radium@0.7.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon-core@1.12.0
	rayon@1.8.0
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	rend@0.4.1
	rkyv@0.7.43
	rkyv_derive@0.7.43
	rustix@0.38.30
	ryu@1.0.16
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sd-notify@0.4.1
	seahash@4.1.0
	serde@1.0.195
	serde_derive@1.0.195
	serde_json@1.0.111
	simd-adler32@0.3.7
	simdutf8@0.1.4
	simplelog@0.12.1
	smallvec@1.12.0
	smithay-client-toolkit@0.18.0
	spin@0.9.8
	spin_sleep@1.2.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.48
	tap@1.0.1
	termcolor@1.1.3
	terminal_size@0.3.0
	termtree@0.4.1
	thiserror-impl@1.0.56
	thiserror@1.0.56
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.16
	time@0.3.31
	tinytemplate@1.2.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unicode-ident@1.0.12
	utf8parse@0.2.1
	uuid@1.6.1
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.90
	wasm-bindgen-macro-support@0.2.90
	wasm-bindgen-macro@0.2.90
	wasm-bindgen-shared@0.2.90
	wasm-bindgen@0.2.90
	wayland-backend@0.3.2
	wayland-client@0.31.1
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.0
	wayland-protocols-wlr@0.2.0
	wayland-protocols@0.31.0
	wayland-scanner@0.31.0
	wayland-sys@0.31.1
	web-sys@0.3.67
	weezl@0.1.7
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	wyz@0.5.1
	xcursor@0.3.5
	xkeysym@0.2.0
	zune-inflate@0.2.54
"

inherit cargo shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/LGFae/swww"
SRC_URI="https://github.com/LGFae/swww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz ${CARGO_CRATE_URIS}"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-DFS-2016"
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
