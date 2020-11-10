# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${P//_beta/b}"

DESCRIPTION="Full color painting software for Linux for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azpainter.html"
SRC_URI="http://azsky2.html.xdomain.jp/arc/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"

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

src_configure() {
	sh ./configure --prefix=/usr CFLAGS="${CFLAGS:-02}" LDFLAGS="${LDFLAGS}"
}
