# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	clap@4.6.6
	clap_builder@4.6.6
	clap_derive@4.6.4
	clap_lex@1.1.0
	colorchoice@1.0.5
	colored@3.1.1
	heck@0.5.0
	is_terminal_polyfill@1.70.2
	once_cell_polyfill@1.70.2
	proc-macro2@1.0.107
	quote@1.0.47
	strsim@0.11.1
	syn@3.0.4
	unicode-ident@1.0.24
	utf8parse@0.2.2
	windows-link@0.2.1
	windows-sys@0.61.2
"

RUST_MIN_VER="1.85.0"

inherit cargo toolchain-funcs

DESCRIPTION="Memory monitoring tool focusing on swap, zswap and zram"
HOMEPAGE="https://github.com/xeome/Zmem"
SRC_URI="
	https://github.com/xeome/Zmem/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/Zmem-${PV}"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+=" MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

# bug #943887
QA_FLAGS_IGNORED="usr/bin/zmem"

src_prepare() {
	default
	if ! tc-is-lto; then
		sed '/lto = "thin"/d' -i Cargo.toml || die
	fi
}
