# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aead@0.5.2
	android_system_properties@0.1.5
	anstream@0.6.21
	anstyle-parse@0.2.7
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.13
	anyhow@1.0.100
	argon2@0.5.3
	arrayref@0.3.9
	arrayvec@0.7.6
	autocfg@1.5.0
	base64ct@1.8.3
	bitflags@2.10.0
	blake2@0.10.6
	blake3@1.8.3
	block-buffer@0.10.4
	bumpalo@3.19.1
	byteorder@1.5.0
	cc@1.2.53
	cfg-if@1.0.4
	chacha20@0.9.1
	chacha20poly1305@0.10.1
	chrono@0.4.43
	cipher@0.4.4
	clap@4.5.54
	clap_builder@4.5.54
	clap_complete@4.5.65
	clap_derive@4.5.49
	clap_lex@0.7.7
	colorchoice@1.0.4
	colored@2.2.0
	constant_time_eq@0.4.2
	core-foundation-sys@0.8.7
	cpufeatures@0.2.17
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crypto-common@0.1.7
	digest@0.10.7
	either@1.15.0
	equivalent@1.0.2
	errno@0.3.14
	fastcdc@3.2.1
	fastrand@2.3.0
	find-msvc-tools@0.1.8
	fs2@0.4.3
	generic-array@0.14.7
	getrandom@0.2.17
	getrandom@0.3.4
	hashbrown@0.16.1
	heck@0.5.0
	hex@0.4.3
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.64
	indexmap@2.13.0
	inout@0.1.4
	is_terminal_polyfill@1.70.2
	itoa@1.0.17
	jobserver@0.1.34
	js-sys@0.3.85
	lazy_static@1.5.0
	libc@0.2.180
	linux-raw-sys@0.11.0
	log@0.4.29
	memchr@2.7.6
	num-traits@0.2.19
	once_cell@1.21.3
	once_cell_polyfill@1.70.2
	opaque-debug@0.3.1
	password-hash@0.5.0
	pkg-config@0.3.32
	poly1305@0.8.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.105
	quote@1.0.43
	r-efi@5.3.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon-core@1.13.0
	rayon@1.11.0
	rpassword@7.4.0
	rtoolbox@0.0.3
	rustix@1.1.3
	rustversion@1.0.22
	ryu@1.0.22
	same-file@1.0.6
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_yaml@0.9.34+deprecated
	shlex@1.3.0
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.114
	tempfile@3.24.0
	typenum@1.19.0
	unicode-ident@1.0.22
	universal-hash@0.5.1
	unsafe-libyaml@0.2.11
	utf8parse@0.2.2
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasm-bindgen-macro-support@0.2.108
	wasm-bindgen-macro@0.2.108
	wasm-bindgen-shared@0.2.108
	wasm-bindgen@0.2.108
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.62.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen@0.51.0
	zerocopy-derive@0.8.33
	zerocopy@0.8.33
	zeroize@1.8.2
	zmij@1.0.16
	zstd-safe@7.2.4
	zstd-sys@2.0.16+zstd.1.5.7
	zstd@0.13.3
"

inherit cargo

DESCRIPTION="a CLI version control system with a CI/CD pipeline"
HOMEPAGE="https://projectgrid.net/portfolio/gittorrent"
SRC_URI="
	https://projectgrid.net/archive/${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}"

LICENSE="0BSD"
LICENSE+=" Apache-2.0 BSD-2 BSD MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare()
{
	default
}

src_compile()
{
	cargo_src_compile
}

src_install()
{
	cargo_src_install
	einstalldocs
}

pkg_postinst()
{
	elog "Thank you for choosing gittorrent"
	elog "For a better experience with this software, consider adding the line"
	elog "alias gt='gittorrent'"
	elog "to the bottom of ~/.bashrc"
}

pkg_postrm()
{
	elog "Thank you for using gittorrent"
	elog "Don't forget to remove the line"
	elog "alias gt='gittorrent'"
	elog "from ~/.bashrc"
}
