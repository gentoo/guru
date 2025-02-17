# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

LIBCOMMUNI_COMMIT="030710ad53dda1541601ccabbad36a12a9e90c78"
MAGIC_COMMIT="e55b9b54d5cf61f8e117cafb17846d7d742dd3b4"
MINIAUDIO_COMMIT="4a5b74bef029b3592c54b6048650ee5f972c1a48"
RAPIDJSON_COMMIT="d87b698d0fcc10a5f632ecbc80a9cb2a8fa094a5"
SERIALIZE_COMMIT="17946d65a41a72b447da37df6e314cded9650c32"
SETTINGS_COMMIT="9e9c2f65f4ae195a96329a90fd6ae24c24fb8f2f"
SIGNALS_COMMIT="d06770649a7e83db780865d09c313a876bf0f4eb"
WEBSOCKETPP_COMMIT="b9aeec6eaf3d5610503439b4fae3581d9aff08e8"

DESCRIPTION="Chat client for https://twitch.tv"
HOMEPAGE="https://chatterino.com/"
SRC_URI="
	https://github.com/Chatterino/chatterino2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Chatterino/libcommuni/archive/${LIBCOMMUNI_COMMIT}.tar.gz
		-> ${PN}-libcommuni-${LIBCOMMUNI_COMMIT}.tar.gz
	https://github.com/Neargye/magic_enum/archive/${MAGIC_COMMIT}.tar.gz
		-> ${PN}-magic-${MAGIC_COMMIT}.tar.gz
	https://github.com/mackron/miniaudio/archive/${MINIAUDIO_COMMIT}.tar.gz
		-> ${PN}-miniaudio-${MINIAUDIO_COMMIT}.tar.gz
	https://github.com/Tencent/rapidjson/archive/${RAPIDJSON_COMMIT}.tar.gz
		-> ${PN}-rapidjson-${RAPIDJSON_COMMIT}.tar.gz
	https://github.com/pajlada/serialize/archive/${SERIALIZE_COMMIT}.tar.gz
		-> ${PN}-serialize-${SERIALIZE_COMMIT}.tar.gz
	https://github.com/pajlada/settings/archive/${SETTINGS_COMMIT}.tar.gz
		-> ${PN}-settings-${SETTINGS_COMMIT}.tar.gz
	https://github.com/pajlada/signals/archive/${SIGNALS_COMMIT}.tar.gz
		-> ${PN}-signals-${SIGNALS_COMMIT}.tar.gz
	https://github.com/zaphoyd/websocketpp/archive/${WEBSOCKETPP_COMMIT}.tar.gz
		-> ${PN}-websocketpp-${WEBSOCKETPP_COMMIT}.tar.gz
"
S="${WORKDIR}/chatterino2-${PV}"

LICENSE="MIT"
# bundled dependencies
LICENSE+=" BSD Unlicense"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/openssl:=
	dev-libs/qtkeychain:=[qt6]
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,network,widgets]
	dev-qt/qtsvg:6
"
# boost-1.87.0: https://github.com/Chatterino/chatterino2/issues/5766
DEPEND="
	${RDEPEND}
	dev-cpp/expected-lite
	<dev-libs/boost-1.87.0
"
BDEPEND="dev-qt/qttools:6[linguist]"

src_prepare() {
	rmdir --ignore-fail-on-non-empty ./lib/*/ || die "can't remove stubbed libdirs"

	local libname
	for libname in libcommuni magic_enum miniaudio rapidjson serialize settings signals websocketpp; do
		ln -sr ../${libname}-* ./lib/${libname} || die "failed to create symlink for ${libname}"
	done

	# bug 936966
	sed 's/-Werror[^[:space:])"]*//' -i --follow-symlinks \
		{src,lib/{magic_enum/test,rapidjson,serialize,settings,websocketpp}}/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_QT6=ON
		-DBUILD_WITH_QTKEYCHAIN=ON
		-DCHATTERINO_UPDATER=OFF
		-DUSE_SYSTEM_QTKEYCHAIN=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "for opening streams in a local video player" net-misc/streamlink
}
