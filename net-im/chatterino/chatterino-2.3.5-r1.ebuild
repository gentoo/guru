# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg-utils

DESCRIPTION="Chat client for https://twitch.tv"
HOMEPAGE="https://chatterino.com/"
SRC_URI="https://github.com/Chatterino/chatterino2/archive/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/Chatterino/libcommuni/archive/a7b32cd.tar.gz -> libcommuni-a7b32cd.tar.gz
https://github.com/Chatterino/qtkeychain/archive/de95462.tar.gz -> qtkeychain-de95462.tar.gz
https://github.com/Tencent/rapidjson/archive/d87b698.tar.gz -> rapidjson-d87b698.tar.gz
https://github.com/zaphoyd/websocketpp/archive/1b11fd3.tar.gz -> websocketpp-1b11fd3.tar.gz
https://github.com/pajlada/serialize/archive/7d37cbf.tar.gz -> serialize-7d37cbf.tar.gz
https://github.com/pajlada/signals/archive/25e4ec3.tar.gz -> signals-25e4ec3.tar.gz
https://github.com/pajlada/settings/archive/04792d8.tar.gz -> settings-04792d8.tar.gz
https://github.com/arsenm/sanitizers-cmake/archive/99e159e.tar.gz -> sanitizers-cmake-99e159e.tar.gz
"

S=${WORKDIR}/chatterino2-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
BDEPEND="dev-qt/qtsvg:5
	dev-libs/boost"
RDEPEND="dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdbus:5
	dev-libs/openssl:="
DEPEND="${RDEPEND}"

src_prepare() {
	rmdir --ignore-fail-on-non-empty ./lib/*/ ./cmake/*/ || die
	ln -sr ../libcommuni-* ./lib/libcommuni || die
	ln -sr ../qtkeychain-* ./lib/qtkeychain || die
	ln -sr ../rapidjson-* ./lib/rapidjson || die
	ln -sr ../websocketpp-* ./lib/websocketpp || die
	ln -sr ../serialize-* ./lib/serialize || die
	ln -sr ../signals-* ./lib/signals || die
	ln -sr ../settings-* ./lib/settings || die
	ln -sr ../sanitizers-cmake-* ./cmake/sanitizers-cmake || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	mv "${D}"/usr/share/icons/hicolor/256x256/apps/{com.chatterino.,}chatterino.png || die
}

pkg_postinst() {
	xdg_icon_cache_update
	optfeature "for opening streams in a local video player" net-misc/streamlink
}

pkg_postrm() {
	xdg_icon_cache_update
}
