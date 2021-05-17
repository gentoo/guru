# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg

DESCRIPTION="Full color painting software for Linux for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azpainter.html"
SRC_URI="http://azsky2.html.xdomain.jp/arc/${P}.tar.xz"

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

DOCS=( AUTHORS ChangeLog ReadMe_en ReadMe_ja manual_ja.html )

src_configure() {
	sh ./configure --prefix=/usr CC="$(tc-getCC)" CFLAGS="${CFLAGS:-02}" LDFLAGS="${LDFLAGS}" || die "./configure failed"
}

src_compile() {
	tc-export AR
	default
}

src_install() {
	default
	rm -r "${D}/usr/share/doc/${PN}" || die
}
