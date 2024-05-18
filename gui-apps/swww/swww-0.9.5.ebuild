# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	adler@1.0.2
	aho-corasick@1.1.3
	aligned-vec@0.5.0
	anes@0.1.6
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	anyhow@1.0.82
	arbitrary@1.3.2
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.4
	assert_cmd@2.0.14
	autocfg@1.2.0
	av1-grain@0.2.3
	avif-serialize@0.8.1
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.5.0
	bitstream-io@2.2.0
	bstr@1.9.1
	built@0.7.2
	bumpalo@3.16.0
	bytemuck@1.15.0
	byteorder@1.5.0
	byteorder-lite@0.1.0
	cast@0.3.0
	cc@1.0.96
	cfg-expr@0.15.8
	cfg-if@1.0.0
	ciborium@0.2.2
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	clap@4.5.4
	clap_builder@4.5.2
	clap_complete@4.5.2
	clap_derive@4.5.4
	clap_lex@0.7.0
	color_quant@1.1.0
	colorchoice@1.0.1
	crc32fast@1.4.0
	criterion@0.5.1
	criterion-plot@0.5.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crunchy@0.2.2
	deranged@0.3.11
	difflib@0.4.0
	dlib@0.5.2
	doc-comment@0.3.3
	downcast-rs@1.2.1
	either@1.11.0
	equivalent@1.0.1
	errno@0.3.8
	exr@1.72.0
	fast_image_resize@3.0.4
	fdeflate@0.3.4
	flate2@1.0.30
	flume@0.11.0
	getrandom@0.2.14
	gif@0.13.1
	half@2.4.1
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	image@0.25.1
	image-webp@0.1.2
	imgref@1.10.1
	indexmap@2.2.6
	interpolate_name@0.2.4
	is-terminal@0.4.12
	is_terminal_polyfill@1.70.0
	itertools@0.10.5
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.31
	jpeg-decoder@0.3.1
	js-sys@0.3.69
	keyframe@1.1.1
	lebe@0.5.2
	libc@0.2.154
	libfuzzer-sys@0.4.7
	libloading@0.8.3
	libm@0.2.8
	linux-raw-sys@0.4.13
	lock_api@0.4.12
	log@0.4.21
	loop9@0.1.5
	maybe-rayon@0.1.1
	memchr@2.7.2
	minimal-lexical@0.2.1
	miniz_oxide@0.7.2
	mint@0.5.9
	new_debug_unreachable@1.0.6
	nom@7.1.3
	noop_proc_macro@0.3.0
	num-bigint@0.4.4
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.1
	num-traits@0.2.18
	num_threads@0.1.7
	once_cell@1.19.0
	oorandom@11.1.3
	paste@1.0.14
	pkg-config@0.3.30
	plotters@0.3.5
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	png@0.17.13
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	predicates@3.1.0
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.81
	profiling@1.0.15
	profiling-procmacros@1.0.15
	qoi@0.4.1
	quick-error@2.0.1
	quick-xml@0.31.0
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rav1e@0.7.1
	ravif@0.11.5
	rayon@1.10.0
	rayon-core@1.12.1
	regex@1.10.4
	regex-automata@0.4.6
	regex-syntax@0.8.3
	rgb@0.8.37
	rustix@0.38.34
	ryu@1.0.17
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sd-notify@0.4.1
	serde@1.0.200
	serde_derive@1.0.200
	serde_json@1.0.116
	serde_spanned@0.6.5
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	simplelog@0.12.2
	smallvec@1.13.2
	spin@0.9.8
	spin_sleep@1.2.0
	strsim@0.11.1
	syn@2.0.60
	system-deps@6.2.2
	target-lexicon@0.12.14
	termcolor@1.4.1
	terminal_size@0.3.0
	termtree@0.4.1
	thiserror@1.0.59
	thiserror-impl@1.0.59
	tiff@0.9.1
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tinytemplate@1.2.1
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.22.12
	unicode-ident@1.0.12
	utf8parse@0.2.1
	v_frame@0.3.8
	version-compare@0.2.0
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	wayland-backend@0.3.3
	wayland-client@0.31.2
	wayland-protocols@0.31.2
	wayland-protocols-wlr@0.2.0
	wayland-scanner@0.31.1
	wayland-sys@0.31.1
	web-sys@0.3.69
	weezl@0.1.8
	winapi-util@0.1.8
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.6.7
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.11
"

declare -A GIT_CRATES=(
	[bitcode]='https://github.com/SoftbearStudios/bitcode;5f25a59be3e66deef721e7eb2369deb1aa32d263;bitcode-%commit%'
	[bitcode_derive]='https://github.com/SoftbearStudios/bitcode;5f25a59be3e66deef721e7eb2369deb1aa32d263;bitcode-%commit%/bitcode_derive'
)

inherit cargo shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/LGFae/swww"
SRC_URI="https://github.com/LGFae/swww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz ${CARGO_CRATE_URIS}"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD ISC MIT
	Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

IUSE="+man"

DEPEND="
	app-arch/lz4
	x11-libs/libxkbcommon[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="
	>=virtual/rust-1.74.0
	man? ( app-text/scdoc )
"

QA_FLAGS_IGNORED="
	usr/bin/${PN}
	usr/bin/${PN}-daemon
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
