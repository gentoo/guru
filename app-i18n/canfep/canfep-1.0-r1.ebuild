# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Canna Japanese kana-kanji frontend processor on console"
HOMEPAGE="https://web.archive.org/web/20170517105759/http://www.geocities.co.jp/SiliconValley-Bay/7584/canfep/"
SRC_URI="https://web.archive.org/web/20181106043248if_/http://www.geocities.co.jp/SiliconValley-Bay/7584/${PN}/${P}.tar.gz"

LICENSE="canfep"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-i18n/canna
	sys-libs/ncurses:=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-utf8.patch"
	"${FILESDIR}/${PN}-posix-pty.patch"
	"${FILESDIR}/${PN}-termcap.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
)

src_compile() {
	tc-export CXX
	LIBS="$($(tc-getPKG_CONFIG) --libs ncurses)" emake
}

src_install() {
	dobin "${PN}"
	dodoc 00{changes,readme}
}
