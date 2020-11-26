# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="Desktop client for Matrix using Qt and C++14"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-qt/qtmultimedia:5[gstreamer,qml]
	dev-qt/qtquickcontrols2:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	app-text/cmark
	dev-libs/tweeny
	dev-db/lmdb++
	>=dev-libs/mtxclient-0.3.0
	dev-cpp/nlohmann_json
"
DEPEND="
	${RDEPEND}
	dev-libs/spdlog
"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	cmake_src_prepare
	xdg_src_prepare

	# TODO: Unbundle SingleApplication, blurhash and cpp-httplib.
}
