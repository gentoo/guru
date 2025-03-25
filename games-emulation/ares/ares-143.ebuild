# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic toolchain-funcs xdg

DESCRIPTION="Cross-platform, open source, multi-system emulator, focusing on accuracy and preservation"
HOMEPAGE="https://github.com/ares-emulator/ares"
SRC_URI="https://github.com/ares-emulator/ares/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk"

RDEPEND="
	>=dev-libs/libchdr-0_p20241211
	media-libs/libsdl2[joystick,sound]
	media-sound/pulseaudio
	x11-base/xorg-proto
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	virtual/libudev
	virtual/opengl
	gtk? (
		dev-libs/glib:2
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3
		x11-libs/gtksourceview:3.0=
		x11-libs/pango
	)
	!gtk? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"

PATCHES=(
	"${FILESDIR}"/0001-build-Fix-build-without-librashader.patch
	"${FILESDIR}"/0002-build-Fix-build-of-hiro-with-Qt5-GUI.patch
	"${FILESDIR}"/0003-Unbundle-libchdr.patch
)

src_prepare() {
	cmake_src_prepare

	if ! use gtk && tc-is-lto; then
		ewarn "The Qt5 GUI of ares is unstable when building with LTO."
		ewarn "If you really want to use LTO, then enable the Gtk GUI."
		ewarn "Also note that you need to force the use of the Qt XCB"
		ewarn "backend via QT_QPA_PLATFORM=xcb if you are running this"
		ewarn "inside a Wayland session."

		filter-lto
	fi
}

src_configure() {
	# Disable the LTO (CMake calls it IPO) handling of the build system.
	local mycmakeargs=(
		-DENABLE_IPO=NO
		-DARES_VERSION_OVERRIDE=${PV}
		-DARES_SKIP_DEPS=YES
		-DARES_ENABLE_LIBRASHADER=OFF
		-DARES_ENABLE_OSS=OFF
		-DARES_ENABLE_ALSA=OFF
		-DARES_ENABLE_AO=OFF
		-DARES_ENABLE_OPENAL=OFF
		-DARES_ENABLE_USBHID=OFF
	)

	if ! use gtk; then
		mycmakeargs+=(-DUSE_QT5=ON)
	fi

	cmake_src_configure
}
