# Copyright 2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="start program in a new pseudo-terminal"
HOMEPAGE="https://hacktivis.me/git/openpt"
SRC_URI="https://distfiles.hacktivis.me/releases/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="MPL-2.0"
SLOT="0"

IUSE="static"

src_compile() {
	use static && export LDFLAGS="${LDFLAGS} -static"
	default
}

src_install() {
	PREFIX='/usr' default
}
