# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="ES-DE (EmulationStation Desktop Edition) frontend for browsing/launching games"
HOMEPAGE="https://es-de.org/"
SRC_URI="https://gitlab.com/es-de/emulationstation-de/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="deinit debug video-hw"

BDEPEND="
	virtual/pkgconfig
	sys-devel/gettext
"

DEPEND="
	dev-libs/icu:=
	dev-libs/libgit2:=
	dev-libs/pugixml
	media-libs/alsa-lib
	media-libs/freeimage
	media-libs/freetype
	media-libs/harfbuzz:=
	media-libs/libsdl2[joystick,video]
	media-libs/mesa
	media-video/ffmpeg:=
	net-misc/curl
	net-wireless/bluez
	app-text/poppler[cxx]
"
RDEPEND="${DEPEND}"

src_configure() {
	local buildtype=Release
	use debug && buildtype=Debug

	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="${buildtype}"
		-DAPPLICATION_UPDATER=OFF
		-DDEINIT_ON_LAUNCH="$(usex deinit ON OFF)"
		-DVIDEO_HW_DECODING="$(usex video-hw ON OFF)"
		-DASAN=OFF
	)

	cmake_src_configure
}
