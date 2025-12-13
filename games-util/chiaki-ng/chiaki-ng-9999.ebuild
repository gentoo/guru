# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VER_MUNIT="439de4a9b136bc3b5163e73d4caf37c590bef875" # Assuming unchanged, will verify if build fails

PYTHON_COMPAT=( python3_{10..14} )
inherit cmake python-single-r1 xdg

DESCRIPTION="Client for PlayStation 4 and PlayStation 5 Remote Play"
HOMEPAGE="https://github.com/streetpea/chiaki-ng"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/streetpea/${PN}.git"
	inherit git-r3
else
	SRC_URI="
		https://github.com/streetpea/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		test? ( https://github.com/nemequ/munit/archive/${VER_MUNIT}.tar.gz -> munit-${VER_MUNIT}.tar.gz )
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+cli +gui +sdl +ffmpeg mbedtls test"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	gui? ( ffmpeg )
"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/libevdev
	dev-libs/jerasure
	dev-libs/nanopb
	media-libs/libplacebo
	media-libs/opus
	net-dns/libidn2
	net-misc/curl
	media-video/pipewire
	sdl? ( media-libs/libsdl2[joystick,haptic] )
	gui? (
		dev-qt/qtbase:6[concurrent,dbus,gui,network,opengl,widgets]
		dev-qt/qtdeclarative:6[network,opengl,widgets,svg]
		dev-qt/qtmultimedia:6
		dev-qt/qtsvg:6
		dev-qt/qtwebchannel:6[qml]
		dev-qt/qtwebengine:6[qml,widgets]
	)
	!mbedtls? ( dev-libs/openssl:= )
	mbedtls? ( net-libs/mbedtls )
	ffmpeg?	( media-video/ffmpeg:= )
"

DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/protobuf[${PYTHON_USEDEP}]')
	dev-libs/protobuf
	virtual/pkgconfig
"

PATCHES=(
	# Use shared nanopb library instead of static
	# https://bugs.gentoo.org/965824
	"${FILESDIR}/${PN}-1.9.9-use-shared-nanopb.patch"
)

src_prepare() {
	cmake_src_prepare

	if use test; then
		rm -r "${S}"/test/munit
		ln -s "${WORKDIR}"/munit-${VER_MUNIT} "${S}"/test/munit
	fi
}

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DCHIAKI_USE_SYSTEM_JERASURE=ON
		-DCHIAKI_USE_SYSTEM_NANOPB=ON
		-DCHIAKI_USE_SYSTEM_CURL=ON
		-DCHIAKI_ENABLE_STEAM_SHORTCUT=OFF # BUG: require cpp-steam-tools, used by steamdeck
		-DCHIAKI_ENABLE_STEAMDECK_NATIVE=OFF # Used by steamdeck
		-DCHIAKI_ENABLE_TESTS=$(usex test)
		-DCHIAKI_ENABLE_CLI=$(usex cli)
		-DCHIAKI_ENABLE_GUI=$(usex gui)
		-DCHIAKI_ENABLE_FFMPEG_DECODER=$(usex ffmpeg)
		-DCHIAKI_LIB_ENABLE_MBEDTLS=$(usex mbedtls)
		-DCHIAKI_GUI_ENABLE_SDL_GAMECONTROLLER=$(usex sdl)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dolib.so "${BUILD_DIR}"/lib/*.so
	use gui && dolib.so "${BUILD_DIR}"/gui/*.so
}
