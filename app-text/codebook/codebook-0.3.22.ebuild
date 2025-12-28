# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Spell Checker for Code"
HOMEPAGE="https://github.com/blopker/codebook"
SRC_URI="
	https://github.com/blopker/codebook/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD CDDL CDLA-Permissive-2.0 ISC MIT MPL-2.0 openssl Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

src_install() {
	cargo_src_install --path crates/codebook-lsp
	dodoc README.md
}
