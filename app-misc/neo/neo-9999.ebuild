# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="cmatrix clone with 32-bit color and Unicode support"
HOMEPAGE="https://github.com/st3w/neo"

if [ "$PV" = 9999 ]; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://github.com/st3w/neo/"
else
	SRC_URI="https://github.com/st3w/neo/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
[ "$PV" = 9999 ] && BDEPEND="
	dev-build/automake
	dev-build/automake-archive
"

src_prepare() {
	default
	[ -f ./configure ] || eautoreconf || die 'autoreconf failed'
}
