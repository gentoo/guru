# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Chat client for https://twitch.tv"
HOMEPAGE="https://chatterino.com/"

CERTIFY_COMMIT="a448a3915ddac716ce76e4b8cbf0e7f4153ed1e2"
EXPECTED_COMMIT="df5814711f5f9111a2515a181bde67f22f2fe716"
LIBCOMMUNI_COMMIT="bb5417c451d764f57f2f1b3e1c9a81496b5521bd"
LUA_COMMIT="1ab3208a1fceb12fca8f24ba57d6e13c5bff15e3"
MAGIC_COMMIT="e55b9b54d5cf61f8e117cafb17846d7d742dd3b4"
MINIAUDIO_COMMIT="347321b27c58d42567e905c715de60ad43a6cb8e"
RAPIDJSON_COMMIT="24b5e7a8b27f42fa16b96fc70aade9106cf7102f"
SERIALIZE_COMMIT="75bc7b9c1054f70d0dd0486f175dea93c7733cc3"
SETTINGS_COMMIT="16b3d5ba6e947e84df74e17a19121d6be8baf36b"
SIGNALS_COMMIT="ef0bd9978826bfb2df536c1312762bacbe0b45fa"
SOL2_COMMIT="2b0d2fe8ba0074e16b499940c4f3126b9c7d3471"

SRC_URI="
	https://github.com/Chatterino/certify/archive/${CERTIFY_COMMIT}.tar.gz
		-> ${PN}-certify-${CERTIFY_COMMIT}.tar.gz
	https://github.com/nonstd-lite/expected-lite/archive/${EXPECTED_COMMIT}.tar.gz
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
"

if [[ "${PV}" = "9999" ]]; then
	EGIT_REPO_URI="https://github.com/Chatterino/chatterino2.git/"
	EGIT_BRANCH="master"
	EGIT_SUBMODULES=() # disable submodules

	inherit git-r3
else
	SRC_URI+="https://github.com/Chatterino/chatterino2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/chatterino2-${PV}"

	KEYWORDS="~amd64"
fi

inherit cmake flag-o-matic optfeature xdg

LICENSE="MIT"
# bundled dependencies
LICENSE+=" Boost-1.0 MIT Unlicense"
SLOT="0"
IUSE="debug libnotify +plugins qtkeychain spell"

RESTRICT="mirror"

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
	qtkeychain? ( dev-libs/qtkeychain:= )
	spell? ( app-text/hunspell )
"
DEPEND="
	${RDEPEND}
	dev-libs/boost:=
"
BDEPEND="dev-qt/qttools:6[linguist]"

pkg_pretend() {
	if ! test-flag-CXX -std=c++23; then
		eerror "${P} requires C++23-capable C++ compiler. Your current compiler"
		eerror "does not seem to support -std=c++23 option. Please upgrade your compiler"
		eerror "to gcc-11 or an equivalent version supporting C++23."
		die "Currently active compiler does not support -std=c++23"
	fi
}

if [[ "${PV}" = "9999" ]]; then
src_unpack() {
	local pkg
	local -a pkgs=(
		certify-${CERTIFY_COMMIT}
		expected-${EXPECTED_COMMIT}
		libcommuni-${LIBCOMMUNI_COMMIT}
		lua-${LUA_COMMIT}
		magic-${MAGIC_COMMIT}
		miniaudio-${MINIAUDIO_COMMIT}
		rapidjson-${RAPIDJSON_COMMIT}
		serialize-${SERIALIZE_COMMIT}
		settings-${SETTINGS_COMMIT}
		signals-${SIGNALS_COMMIT}
		sol2-${SOL2_COMMIT}
	)

	for pkg in "${pkgs[@]}"; do
		unpack ${PN}-${pkg}.tar.gz
	done

	git-r3_src_unpack
}
fi

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
	)

	for lib in "${libs[@]}"; do
		rmdir lib/"${lib}" || die "can't remove stubbed libdirs"
		ln -sr ../"${lib}"-* ./lib/"${lib}" || die "failed to create symlink for ${lib}"
	done

	# bundled lua -- see chatterino2/pull/6495
	rmdir lib/lua/src || die
	ln -sr ../lua-* lib/lua/src || die

	# delete ccache detection - already handled by portage
	sed -i -e '/CCACHE_PROGRAM ccache/,+6d' CMakeLists.txt || sed "Sed ccache broke !"

	# disable doxygen automagic detection
	# doyxgen doc generation seems anyway broken for now
	sed -i -e '/find_package(Doxygen)/d' CMakeLists.txt || sed "Sed doxygen1 broke !"
	sed -i -e 's/Build rapidjson documentation." ON/Build rapidjson documentation." OFF/g' \
		lib/rapidjson/CMakeLists.txt || sed "Sed doxygen2 broke !"

	# bug 936966
	sed 's/-Werror[^[:space:])"]*//' -i --follow-symlinks \
		{src,lib/{magic_enum/test,rapidjson,serialize,settings}}/CMakeLists.txt || \
			die "Sed Werror broke !"

	cmake_src_prepare
}

src_configure() {
	local CMAKE_BUILD_TYPE=$(usex debug Debug Release)

	local mycmakeargs=(
		-DUSE_SYSTEM_QTKEYCHAIN=ON
		-DBUILD_WITH_QTKEYCHAIN=$(usex qtkeychain)
		-DBUILD_WITH_QT6=ON
		-DBUILD_WITH_LIBNOTIFY=$(usex libnotify)
		-DCHATTERINO_PLUGINS=$(usex plugins)
		-DCHATTERINO_SPELLCHECK=$(usex spell)
		-DCHATTERINO_UPDATER=OFF
	)

	use debug || append-cxxflags -DNDEBUG

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "for opening streams in a local video player" net-misc/streamlink
}
