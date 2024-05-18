# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	adler@1.0.2
	anstream@0.6.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	base64@0.21.5
	bitflags@1.3.2
	bitflags@2.4.1
	cc@1.0.83
	cfg-if@1.0.0
	clap@4.4.10
	clap_builder@4.4.9
	clap_complete@4.4.4
	clap_lex@0.6.0
	clipboard-win@4.5.0
	colorchoice@1.0.0
	crc32fast@1.3.2
	deranged@0.3.9
	diff@0.1.13
	directories@5.0.1
	dirs-sys@0.4.1
	endian-type@0.1.2
	equivalent@1.0.1
	errno@0.3.8
	error-code@2.3.1
	fd-lock@3.0.13
	flate2@1.0.28
	form_urlencoded@1.2.1
	getrandom@0.2.11
	hashbrown@0.14.3
	home@0.5.5
	idna@0.5.0
	indexmap@2.1.0
	itoa@1.0.9
	libc@0.2.150
	libredox@0.0.1
	libredox@0.0.2
	linux-raw-sys@0.4.11
	log@0.4.20
	memchr@2.6.4
	miniz_oxide@0.7.1
	nibble_vec@0.1.0
	nix@0.26.4
	num_threads@0.1.6
	numtoa@0.1.0
	once_cell@1.18.0
	option-ext@0.2.0
	percent-encoding@2.3.1
	powerfmt@0.2.0
	pretty_assertions@1.4.0
	proc-macro2@1.0.70
	quote@1.0.33
	radix_trie@0.2.1
	redox_syscall@0.4.1
	redox_termios@0.1.3
	redox_users@0.4.4
	ring@0.17.6
	rustix@0.38.25
	rustls-webpki@0.101.7
	rustls@0.21.9
	rustyline@12.0.0
	ryu@1.0.15
	scopeguard@1.2.0
	sct@0.7.1
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	serde_spanned@0.6.4
	smallvec@1.11.2
	smawk@0.3.2
	spin@0.9.8
	str-buf@1.0.6
	strsim@0.10.0
	syn@2.0.39
	terminal_size@0.3.0
	termion@2.0.3
	textwrap@0.16.0
	thiserror-impl@1.0.50
	thiserror@1.0.50
	time-core@0.1.2
	time-macros@0.2.15
	time@0.3.30
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	toml@0.8.8
	toml_datetime@0.6.5
	toml_edit@0.21.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.12
	unicode-linebreak@0.1.5
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	untrusted@0.9.0
	ureq@2.9.1
	url@2.5.0
	utf8parse@0.2.1
	wasi@0.11.0+wasi-snapshot-preview1
	webpki-roots@0.25.3
	winapi-i686-pc-windows-gnu@0.4.0
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
	winnow@0.5.19
	yansi@0.5.1
"

inherit cargo shell-completion

DESCRIPTION="Command-line PeerTube viewer inspired by youtube-viewer"
HOMEPAGE="https://gitlab.com/peertube-viewer/peertube-viewer-rs"
SRC_URI="
	https://gitlab.com/peertube-viewer/peertube-viewer-rs/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0 Boost-1.0 ISC MIT MPL-2.0 openssl Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/peertube-viewer-rs"

src_install() {
	cargo_src_install
	doman "${PN}.1"
	newbashcomp "completions/${PN}.bash" "${PN}"
	dofishcomp "completions/${PN}.fish"
	dozshcomp "completions/_${PN}"
}
