# Copyright 2018-2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Full color painting software for Linux for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/azpainter.html https://github.com/Symbian9/azpainter"
SRC_URI="https://osdn.net/dl/azpainter/${P}.tar.xz"

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
