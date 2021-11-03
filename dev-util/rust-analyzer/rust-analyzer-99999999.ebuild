# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

inherit cargo

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rust-analyzer/rust-analyzer"
else
	KEYWORDS="~amd64"
	MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
	SRC_URI="https://github.com/rust-analyzer/rust-analyzer/archive/${MY_PV}.tar.gz -> ${P}.tar.gz $(cargo_crate_uris)"
fi

DESCRIPTION="An implementation of Language Server Protocol for the Rust programming language"
HOMEPAGE="https://rust-analyzer.github.io"

LICENSE="0BSD Apache-2.0 Artistic-2 BSD Boost-1.0 CC0-1.0 ISC MIT Unlicense ZLIB"
RESTRICT="mirror"
SLOT="0"
IUSE=""

DEPEND="|| ( >=dev-lang/rust-1.56.0[rls] >=dev-lang/rust-bin-1.56.0[rls] )"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
		mv -T "${PN}-${MY_PV}" "${P}" || die
	fi
}

src_install() {
	cargo_src_install --path "./crates/rust-analyzer"
}
