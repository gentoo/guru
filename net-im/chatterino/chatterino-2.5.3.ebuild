# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

CERTIFY_COMMIT="a448a3915ddac716ce76e4b8cbf0e7f4153ed1e2"
EXPECTED_COMMIT="54ca18bcea8e39c41650d82268077d559c695aa5"
LIBCOMMUNI_COMMIT="2979eb96262756047a8dca47f2e509168138c0d0"
LUA_COMMIT="1ab3208a1fceb12fca8f24ba57d6e13c5bff15e3"
MAGIC_COMMIT="e55b9b54d5cf61f8e117cafb17846d7d742dd3b4"
MINIAUDIO_COMMIT="350784a9467a79d0fa65802132668e5afbcf3777"
RAPIDJSON_COMMIT="d87b698d0fcc10a5f632ecbc80a9cb2a8fa094a5"
SERIALIZE_COMMIT="17946d65a41a72b447da37df6e314cded9650c32"
SETTINGS_COMMIT="c141a40d2d493646cd8f0b1e06251a828dfdfdd2"
SIGNALS_COMMIT="d06770649a7e83db780865d09c313a876bf0f4eb"
SOL2_COMMIT="2b0d2fe8ba0074e16b499940c4f3126b9c7d3471"
WEBSOCKETPP_COMMIT="f1736a8e72b910810ff6869fe20f647a62f3bc35"

DESCRIPTION="Chat client for https://twitch.tv"
HOMEPAGE="https://chatterino.com/"
SRC_URI="
	https://github.com/Chatterino/chatterino2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Chatterino/certify/archive/${CERTIFY_COMMIT}.tar.gz
		-> ${PN}-certify-${CERTIFY_COMMIT}.tar.gz
	https://github.com/martinmoene/expected-lite/archive/${EXPECTED_COMMIT}.tar.gz
		-> ${PN}-expected-${EXPECTED_COMMIT}.tar.gz
	https://github.com/Chatterino/libcommuni/archive/${LIBCOMMUNI_COMMIT}.tar.gz
		-> ${PN}-libcommuni-${LIBCOMMUNI_COMMIT}.tar.gz
	https://github.com/lua/lua/archive/${LUA_COMMIT}.tar.gz
		-> ${PN}-lua-${LUA_COMMIT}.tar.gz
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
	https://github.com/ThePhD/sol2/archive/${SOL2_COMMIT}.tar.gz
		-> ${PN}-sol2-${SOL2_COMMIT}.tar.gz
	https://github.com/Chatterino/websocketpp/archive/${WEBSOCKETPP_COMMIT}.tar.gz
		-> ${PN}-websocketpp-${WEBSOCKETPP_COMMIT}.tar.gz
"
S="${WORKDIR}/chatterino2-${PV}"

LICENSE="MIT"
# bundled dependencies
LICENSE+=" Boost-1.0 BSD MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify +plugins qtkeychain"

RDEPEND="
	dev-libs/openssl:=
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[concurrent,gui,network,widgets]
	dev-qt/qtsvg:6
	dev-qt/qtimageformats:6
	libnotify? (
		dev-libs/glib:2
		x11-libs/gdk-pixbuf:2
		x11-libs/libnotify
	)
	qtkeychain? ( dev-libs/qtkeychain:=[qt6] )
"
DEPEND="
	${RDEPEND}
	dev-libs/boost
"
BDEPEND="dev-qt/qttools:6[linguist]"

PATCHES=(
	"${FILESDIR}"/${PN}-2.5.2-disable-ccache.patch
)

src_prepare() {
	local lib
	local -a libs=(
		certify
		expected-lite
		libcommuni
		magic_enum
		miniaudio
		rapidjson
		serialize
		settings
		signals
		sol2
		websocketpp
	)
	for lib in "${libs[@]}"; do
		rmdir lib/"${lib}" || die "can't remove stubbed libdirs"
		ln -sr ../"${lib}"-* ./lib/"${lib}" || die "failed to create symlink for ${lib}"
	done
	rmdir lib/lua/src || die
	ln -sr ../lua-* lib/lua/src || die

	# bug 936966
	sed 's/-Werror[^[:space:])"]*//' -i --follow-symlinks \
		{src,lib/{magic_enum/test,rapidjson,serialize,settings,websocketpp}}/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_QTKEYCHAIN=ON
		-DBUILD_WITH_QTKEYCHAIN=$(usex qtkeychain)
		-DBUILD_WITH_QT6=ON
		-DBUILD_WITH_LIBNOTIFY=$(usex libnotify)
		-DCHATTERINO_PLUGINS=$(usex plugins)
		-DCHATTERINO_UPDATER=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "for opening streams in a local video player" net-misc/streamlink
}
