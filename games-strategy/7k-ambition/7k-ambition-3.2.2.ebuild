# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop toolchain-funcs

DESCRIPTION="Seven Kingdoms: Ambition"
HOMEPAGE="https://seven-kingdoms-ambition.sourceforge.io/"
SRC_URI="https://github.com/Infiltrator/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
        https://sourceforge.net/projects/seven-kingdoms-ambition/files/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

DEPEND="dev-libs/boost
        media-libs/libsdl2[X,video]
        media-libs/openal
        net-misc/curl
        net-libs/enet:1.3"
RDEPEND="${DEPEND}"

src_prepare() {
        default
        eautoreconf
}

src_compile() {
        emake AR="$(tc-getAR)"
}

src_install() {
        default

        doicon "${DISTDIR}/${PN}.png"
        make_desktop_entry "${PN}" "Seven Kingdoms: Ambition" "${PN}" "Game;StrategyGame"
}
