# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://www.pulkomandy.tk/projects/GrafX2"
SRC_URI="http://www.pulkomandy.tk/projects/GrafX2/downloads/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ttf lua"

PATCHES=(
	"${FILESDIR}/${PN}-desktop-file.patch"
)

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/freetype
	media-libs/libpng
	ttf? ( media-libs/sdl-ttf )
	lua? ( >=dev-lang/lua-5.1.0 )"
RDEPEND=""

src_unpack()
{
	unpack ${P}-src.tgz && mv ${PN} ${P}
}

src_prepare()
{
	eapply ${PATCHES}

	eapply_user

	cd ${WORKDIR}/${P}/src/
	sed -i s/lua5\.1/lua/g Makefile
}

src_compile()
{
	use ttf || MYCNF="NOTTF=1"
	use lua || MYCNF="${MYCNF} NOLUA=1"

	cd ${WORKDIR}/${P}/src/
	emake ${MYCNF} || die "emake failed"
}

src_install()
{
	cd ${WORKDIR}/${P}/src/
	emake ${MYCNF} DESTDIR="${D}" PREFIX="/usr" install || die "Install failed"
}

pkg_postinst()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm()
{
	xdg_desktop_database_update
	xdg_icon_cache_update
}
