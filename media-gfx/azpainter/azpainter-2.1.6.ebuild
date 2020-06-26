# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Full color painting software for Linux for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azpainter.html https://github.com/Symbian9/azpainter"
SRC_URI="https://github.com/Symbian9/azpainter/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/libX11:=
	x11-libs/libXext:=
	x11-libs/libXi:=
	media-libs/freetype:=
	media-libs/fontconfig:=
	sys-libs/zlib:=
	media-libs/libpng:=
	media-libs/libjpeg-turbo:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fix_configure.patch"
	"${FILESDIR}/${P}-signed_char.patch"
)

src_configure() {
	sh ./configure --prefix=/usr CFLAGS="${CFLAGS:-02}" LDFLAGS="${LDFLAGS}"
}
