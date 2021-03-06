# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg-utils

DESCRIPTION="The essential to control music from your SONOS devices on Linux platforms"
HOMEPAGE="http://janbar.github.io/noson-app/index.html"
SRC_URI="https://github.com/janbar/noson-app/archive/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
   >=dev-qt/qtcore-5.9
   >=dev-qt/qtnetwork-5.9
   >=dev-qt/qttranslations-5.9
   >=dev-qt/qtgui-5.9
   >=dev-qt/qtquickcontrols2-5.9
   >=dev-util/cmake-3.8.2
   dev-libs/openssl:0
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${WORKDIR}/${P}"

src_configure() {
    mycmakeargs=(-DCMAKE_BUILD_TYPE=Release ..)
    cmake_src_configure
}

pkg_postinst() {
   xdg_icon_cache_update
}

pkg_postrm() {
   xdg_icon_cache_update
}