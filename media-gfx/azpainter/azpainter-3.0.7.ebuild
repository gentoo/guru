# Copyright 2018-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo ninja-utils toolchain-funcs xdg

DESCRIPTION="Full color painting software for Linux for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azpainter.html
	https://gitlab.com/azelpg/azpainter"
SRC_URI="https://gitlab.com/azelpg/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	media-libs/libwebp:=
	media-libs/tiff:=
	sys-libs/zlib:=
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXi
"
RDEPEND="${DEPEND}"
BDEPEND="
	${NINJA_DEPEND}
	virtual/pkgconfig
"

DOCS=(
	about_mlk_en.txt
	about_mlk_ja.txt
	translation/tool/about-en.txt
	translation/tool/about-ja.txt
)

PATCHES=( "${FILESDIR}/${P}-strict-aliasing.patch" )

src_prepare() {
	sed -i "s|ar rc|$(tc-getAR) rc|" build.ninja.in || die
	sed -i "s|doc/@PACKAGE_NAME@|doc/${PF}|" install.sh.in || die
	default
}

src_configure() {
	edo sh ./configure --prefix="${EPREFIX}/usr" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_compile() {
	eninja -C build
}

src_install() {
	DESTDIR="${D}" eninja -C build install
}
