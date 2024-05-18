# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg-utils

DESCRIPTION="Chat client for https://twitch.tv"
HOMEPAGE="https://chatterino.com/"
SRC_URI="
	https://github.com/Chatterino/chatterino2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Chatterino/libcommuni/archive/030710a.tar.gz -> libcommuni-030710a.tar.gz
	https://github.com/Neargye/magic_enum/archive/e1a68e9.tar.gz -> magic_enum-e1a68e9.tar.gz
	https://github.com/mackron/miniaudio/archive/3898fff.tar.gz -> miniaudio-3898fff.tar.gz
	https://github.com/Tencent/rapidjson/archive/d87b698.tar.gz -> rapidjson-d87b698.tar.gz
	https://github.com/pajlada/serialize/archive/bbf0a34.tar.gz -> serialize-bbf0a34.tar.gz
	https://github.com/pajlada/settings/archive/f168c09.tar.gz -> settings-f168c09.tar.gz
	https://github.com/pajlada/signals/archive/6561aa5.tar.gz -> signals-6561aa5.tar.gz
	https://github.com/zaphoyd/websocketpp/archive/b9aeec6.tar.gz -> websocketpp-b9aeec6.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/c3dc841.tar.gz -> sanitizers-cmake-c3dc841.tar.gz
"

S=${WORKDIR}/chatterino2-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/openssl:=
	dev-libs/qtkeychain:=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
DEPEND="
	${RDEPEND}
	dev-libs/boost
"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	rmdir --ignore-fail-on-non-empty ./lib/*/ ./cmake/*/ || die
	ln -sr ../libcommuni-* ./lib/libcommuni || die
	ln -sr ../magic_enum-* ./lib/magic_enum || die
	ln -sr ../miniaudio-* ./lib/miniaudio || die
	ln -sr ../rapidjson-* ./lib/rapidjson || die
	ln -sr ../serialize-* ./lib/serialize || die
	ln -sr ../settings-* ./lib/settings || die
	ln -sr ../signals-* ./lib/signals || die
	ln -sr ../websocketpp-* ./lib/websocketpp || die
	ln -sr ../sanitizers-cmake-* ./cmake/sanitizers-cmake || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_QTKEYCHAIN=ON
	)
	cmake_src_configure
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
