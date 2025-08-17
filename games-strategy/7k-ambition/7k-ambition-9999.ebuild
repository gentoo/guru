# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/seven-kingdoms-ambition/code"
	EGIT_BRANCH="next"
else
	SRC_URI="https://github.com/Infiltrator/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Seven Kingdoms: Ambition"
HOMEPAGE="https://seven-kingdoms-ambition.sourceforge.io/"
SRC_URI+=" https://sourceforge.net/projects/seven-kingdoms-ambition/files/${PN}.png/download -> ${PN}.png"

LICENSE="GPL-2"
if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
	SLOT="9999"
else
	SLOT="$(ver_cut 1-2)"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
fi

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

src_configure() {
	econf \
		--prefix="${EPREFIX}/opt/games/${P}" \
		--datadir="${EPREFIX}/opt/games/${P}/share" \
		--sysconfdir="${EPREFIX}/opt/games/${P}/etc" \
		--localedir="${EPREFIX}/opt/games/${P}/share/locale"
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	emake DESTDIR="${D}" install

	insinto "/opt/games/${P}/share/pixmaps"
	newins "${DISTDIR}/${PN}.png" "${PN}.png"

	dosym "../../opt/games/${P}/bin/${PN}" "/usr/bin/${PN}-${PV}"

	make_desktop_entry "${PN}-${PV}" "Seven Kingdoms: Ambition ${PV}" \
		"/opt/games/${P}/share/pixmaps/${PN}.png" "Game;StrategyGame"
}

