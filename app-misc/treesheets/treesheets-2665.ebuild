# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"

inherit cmake wxwidgets xdg

DESCRIPTION="Open source free form data organizer"
HOMEPAGE="https://strlen.com/treesheets/"
SRC_URI="
	https://github.com/aardappel/treesheets/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/aardappel/lobster/archive/refs/tags/v2025.3.tar.gz -> lobster-v2025.3.tar.gz"
PATCHES=("${FILESDIR}/2567-cmake-wxwidgets.patch")
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=media-libs/libsdl2-2.30.7-r1
	>=app-text/gspell-1.12.2
	>=x11-libs/wxGTK-3.2.8.1-r2[X]"
DEPEND="${RDEPEND}"

HTML_DOCS="TS/docs"

src_prepare() {
	mkdir "${WORKDIR}/${P}/_deps" || die
	ln -s "${WORKDIR}/lobster-2025.3" "${WORKDIR}/${P}/lobster-src" || die
	cmake_src_prepare
}

src_configure() {
	setup-wxwidgets
	cmake_src_configure
}

src_install() {
	cmake_src_install
	docompress -x /usr/share/doc/${PF}/examples
}
