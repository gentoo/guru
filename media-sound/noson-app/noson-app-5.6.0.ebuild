# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xdg cmake

DESCRIPTION="The essential to control music from your SONOS devices on Linux platforms"
HOMEPAGE="http://janbar.github.io/noson-app/index.html"
SRC_URI="https://github.com/janbar/noson-app/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-qt/qtcore-5.9
	>=dev-qt/qtdbus-5.9
	>=dev-qt/qtnetwork-5.9
	>=dev-qt/qttranslations-5.9
	>=dev-qt/qtgui-5.9
	>=dev-qt/qtquickcontrols2-5.9
	>=dev-qt/qtsvg-5.9
	dev-libs/openssl:0
	media-libs/flac
	media-libs/libpulse
"
RDEPEND="${DEPEND}"

src_configure() {
	cmake_src_configure
}
