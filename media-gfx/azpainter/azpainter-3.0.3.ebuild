# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg

DESCRIPTION="Full color painting software for Linux for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azpainter.html
https://gitlab.com/azelpg/azpainter"
SRC_URI="https://gitlab.com/azelpg/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0/3"
KEYWORDS="~amd64 ~x86"

DEPEND="
	x11-libs/libX11:=
	x11-libs/libXext:=
	x11-libs/libXcursor:=
	x11-libs/libXi:=
	media-libs/freetype:=
	media-libs/fontconfig:=
	sys-libs/zlib:=
	media-libs/libpng:=
	media-libs/libjpeg-turbo:=
	media-libs/libwebp:=
	media-libs/tiff:=
"
RDEPEND="${DEPEND}"

DOCS=(
	about_mlk_en.txt
	about_mlk_ja.txt
	translation/tool/about-en.txt
	translation/tool/about-ja.txt
)

src_configure() {
	sh ./configure \
		--prefix=/usr \
		--docdir=/usr/share/doc/${PF} \
		CC="$(tc-getCC)" CFLAGS="${CFLAGS:-02}" LDFLAGS="${LDFLAGS}" || die
}

src_compile() {
	tc-export AR
	default
}

src_install() {
	default
	rm "${ED}"/usr/share/doc/${PF}/GPL3
}
