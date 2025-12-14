EAPI=8

CRATES="
	adler2@2.0.1
	aho-corasick@1.1.4
	alsa-sys@0.3.1
	alsa@0.9.1
	arrayvec@0.7.6
	asio-sys@0.2.3
	autocfg@1.5.0
	bindgen@0.72.1
	bitflags@1.3.2
	bitflags@2.10.0
	bumpalo@3.19.0
	bytemuck@1.24.0
	byteorder@1.5.0
	bytes@1.11.0
	cc@1.2.49
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	clang-sys@1.8.1
	combine@4.6.7
	coreaudio-rs@0.13.0
	cpal@0.16.0
	crc32fast@1.5.0
	crossbeam-channel@0.5.15
	crossbeam-utils@0.8.21
	dasp_sample@0.11.0
	discord-presence@2.1.1
	dispatch2@0.3.0
	either@1.15.0
	encoding_rs@0.8.35
	equivalent@1.0.2
	extended@0.1.0
	find-msvc-tools@0.1.5
	flate2@1.1.5
	getrandom@0.3.4
	glob@0.3.3
	hashbrown@0.16.1
	home@0.5.12
	id3@1.16.3
	indexmap@2.12.1
	itertools@0.13.0
	itoa@1.0.15
	jack-sys@0.5.1
	jack@0.13.3
	jni-sys@0.3.0
	jni@0.21.1
	js-sys@0.3.83
	lazy_static@1.5.0
	libc@0.2.178
	libloading@0.7.4
	libloading@0.8.9
	lock_api@0.4.14
	log@0.4.29
	mach2@0.4.3
	memchr@2.7.6
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mp3-duration@0.1.10
	ncurses@5.101.0
	ndk-context@0.1.1
	ndk-sys@0.6.0+11769913
	ndk@0.9.0
	nix@0.29.0
	nom@7.1.3
	num-bigint@0.4.6
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	num_enum@0.7.5
	num_enum_derive@0.7.5
	objc2-audio-toolbox@0.3.2
	objc2-core-audio-types@0.3.2
	objc2-core-audio@0.3.2
	objc2-core-foundation@0.3.2
	objc2-encode@4.1.0
	objc2-foundation@0.3.2
	objc2@0.6.3
	once_cell@1.21.3
	pancurses@0.17.0
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	parse_cfg@4.1.1
	paste@1.0.15
	pdcurses-sys@0.7.1
	pkg-config@0.3.32
	ppv-lite86@0.2.21
	prettyplease@0.2.37
	proc-macro-crate@3.4.0
	proc-macro-error-attr2@2.0.0
	proc-macro-error2@2.0.1
	proc-macro2@1.0.103
	quork-proc@0.3.2
	quork@0.7.2
	quote@1.0.42
	r-efi@5.3.0
	rand@0.9.2
	rand_chacha@0.9.0
	rand_core@0.9.3
	redox_syscall@0.5.18
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rodio@0.21.1
	rustc-hash@2.1.1
	rustversion@1.0.22
	ryu@1.0.20
	same-file@1.0.6
	scopeguard@1.2.0
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.145
	shlex@1.3.0
	simd-adler32@0.3.8
	smallvec@1.15.1
	symphonia-bundle-flac@0.5.5
	symphonia-bundle-mp3@0.5.5
	symphonia-codec-aac@0.5.5
	symphonia-codec-pcm@0.5.5
	symphonia-codec-vorbis@0.5.5
	symphonia-core@0.5.5
	symphonia-format-isomp4@0.5.5
	symphonia-format-ogg@0.5.5
	symphonia-format-riff@0.5.5
	symphonia-metadata@0.5.5
	symphonia-utils-xiph@0.5.5
	symphonia@0.5.5
	syn@2.0.111
	thiserror-impl@1.0.69
	thiserror-impl@2.0.17
	thiserror@1.0.69
	thiserror@2.0.17
	toml_datetime@0.7.3
	toml_edit@0.23.9
	toml_parser@1.0.4
	unicode-ident@1.0.22
	unicode-segmentation@1.12.0
	unicode-width@0.2.2
	uuid@1.19.0
	walkdir@2.5.0
	wasip2@1.0.1+wasi-0.2.4
	wasm-bindgen-futures@0.4.56
	wasm-bindgen-macro-support@0.2.106
	wasm-bindgen-macro@0.2.106
	wasm-bindgen-shared@0.2.106
	wasm-bindgen@0.2.106
	web-sys@0.3.83
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.54.0
	windows-core@0.58.0
	windows-implement@0.58.0
	windows-interface@0.58.0
	windows-link@0.2.1
	windows-result@0.1.2
	windows-result@0.2.0
	windows-strings@0.1.0
	windows-sys@0.45.0
	windows-sys@0.61.2
	windows-targets@0.42.2
	windows-targets@0.52.6
	windows@0.54.0
	windows@0.58.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.52.6
	winnow@0.7.14
	winreg@0.5.1
	wit-bindgen@0.46.0
	zerocopy-derive@0.8.31
	zerocopy@0.8.31
"

RUST_MIN_VER="1.88"

inherit cargo

DESCRIPTION="A terminal user interface music player in Rust"
HOMEPAGE="https://github.com/evilja/neocrystal"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/evilja/neocrystal.git"
else
	SRC_URI="https://github.com/evilja/neocrystal/archive/refs/tags/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	SRC_URI+=" ${CARGO_CRATE_URIS}"
	RESTRICT="mirror"
	KEYWORDS="~amd64"
fi
#package license
LICENSE="GPL-3+"
#crate licenses
LICENSE+=" Apache-2.0 BSD MPL-2.0 Unicode-3.0"
SLOT="0"

RDEPEND="
	media-libs/alsa-lib
	sys-libs/ncurses
"
BDEPEND="
	virtual/pkgconfig
"

DEPEND=${RDEPEND}

src_unpack() {
	if [[ $PV == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	default
	eapply "${FILESDIR}"/remove-win32.patch
}

pkg_postinst() {
	einfo "neocrystal won't work without a ~/Music/"
	einfo "and you need to have alsa support to have a working playback"
	einfo "because cpal crate uses alsa for linux."
}
