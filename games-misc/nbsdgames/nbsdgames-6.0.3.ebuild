# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="New, improved, text-based modern games"
HOMEPAGE="https://github.com/abakh/nbsdgames"
SRC_URI="https://github.com/abakh/nbsdgames/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
# launch-test
RESTRICT="test"

DEPEND="sys-libs/ncurses:="
RDEPEND="
	${DEPEND}
	acct-group/gamestat
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-group_scores.patch
)

src_compile() {
	tc-export CC PKG_CONFIG
	append-cflags -DSCORES_GW
	emake PREFIX="${EPREFIX}" SCORES_DIR="${EPREFIX}/var/games/${PN}" nb
}

src_install() {
	emake PREFIX="${EPREFIX}" DESTDIR="${D}" nbinstall nbmanpages

	local b
	for b in "${ED}"/usr/bin/*; do
		fowners :gamestat "${b#${ED}}"
		fperms g+s "${b#${ED}}"
	done

	diropts -m 2770 -g gamestat
	dodir /var/games/${PN}
	keepdir /var/games/${PN}
}
