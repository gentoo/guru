# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	bitflags@2.6.0
	block-buffer@0.10.4
	byteorder@1.5.0
	cfg-if@1.0.0
	clap@4.5.18
	clap_builder@4.5.18
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	cpufeatures@0.2.14
	crypto-common@0.1.6
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	equivalent@1.0.1
	generic-array@0.14.7
	getrandom@0.2.15
	hashbrown@0.14.5
	heck@0.5.0
	indexmap@2.5.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	libc@0.2.159
	libredox@0.1.3
	memchr@2.7.4
	option-ext@0.2.0
	ppv-lite86@0.2.20
	proc-macro2@1.0.86
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_users@0.4.6
	rust-embed-impl@8.5.0
	rust-embed-utils@8.5.0
	rust-embed@8.5.0
	ryu@1.0.18
	same-file@1.0.6
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_spanned@0.6.8
	sha2@0.10.8
	strsim@0.11.1
	syn@2.0.77
	thiserror-impl@1.0.64
	thiserror@1.0.64
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	typenum@1.17.0
	unicode-ident@1.0.13
	utf8parse@0.2.2
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-util@0.1.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.6.20
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo

DESCRIPTION="Print pokemon sprites in your terminal"
HOMEPAGE="https://github.com/yannjor/krabby"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yannjor/${PN}.git"
else
	SRC_URI="
	https://github.com/yannjor/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	MIT MPL-2.0 Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}
