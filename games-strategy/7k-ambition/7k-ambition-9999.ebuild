# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop toolchain-funcs xdg

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/seven-kingdoms-ambition/code"
	EGIT_BRANCH="next"
else
	SRC_URI="https://github.com/Infiltrator/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Seven Kingdoms: Ambition"
HOMEPAGE="https://seven-kingdoms-ambition.sourceforge.io/"
SRC_URI+=" https://sourceforge.net/projects/seven-kingdoms-ambition/files/${PN}.png/download -> ${PN}.png
	music? ( https://www.7kfans.com/downloads/7kaa-music-2.15.tar.bz2 )
"

LICENSE="GPL-2
		music? ( 7k-music )"
SLOT="0"
IUSE="+nls +multiplayer +music"
RESTRICT="music? ( bindist ) mirror"

DEPEND="
	dev-libs/boost:=
	nls? ( <=sys-devel/gettext-0.22.5-r2 )
	multiplayer? (
		net-libs/enet:1.3=
		net-misc/curl:=
	)
	media-libs/libsdl2[X,video]
	media-libs/openal:=
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
	fi

	default
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_enable multiplayer)
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	default

	if use music ; then
		insinto "usr/share/${PN}/"
		doins -r "${WORKDIR}/7kaa-music/MUSIC"

		dodoc "${WORKDIR}/7kaa-music/README-Music.txt" "${WORKDIR}/7kaa-music/COPYING-Music.txt"
	fi

	doicon "${DISTDIR}/${PN}.png"

	make_desktop_entry ${PN} "Seven Kingdoms: Ambition" /usr/share/pixmaps/${PN}.png Game
}
