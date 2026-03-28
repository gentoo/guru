# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev xdg git-r3

DESCRIPTION="Modernized fork of Linuxtrack headtracking software"
HOMEPAGE="https://github.com/StarTuz/linuxtrack-Qt6-Wayland"

MY_PN="linuxtrack-Qt6-Wayland"
EGIT_REPO_URI="https://github.com/StarTuz/${MY_PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

IUSE="+winebridge"

RDEPEND="
	dev-qt/qtbase:6
	dev-libs/libusb
	dev-libs/mxml
	media-libs/liblo
	media-libs/opencv
	virtual/opengl
	winebridge? ( virtual/wine )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_WINE_BRIDGE=$(usex winebridge)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Fix rpaths - These three have DT_RUNPATH='-Wl:/usr/lib' otherwise.
	patchelf --set-rpath '$ORIGIN' "${ED}/usr/lib/linuxtrack/NPClient64.dll.so" || die 'Could not fix rpath'
	patchelf --set-rpath '$ORIGIN' "${ED}/usr/lib/linuxtrack/NPClient64UDP.dll.so" || die 'Could not fix rpath'
	patchelf --set-rpath '$ORIGIN' "${ED}/usr/lib/linuxtrack/Tester64.exe.so" || die 'Could not fix rpath'

	# Move docs to corret location (CMakeLists.txt hard-codes /usr/share/doc/linuxtrack)
	mv "${ED}/usr/share/doc/linuxtrack" "${ED}/usr/share/doc/${PN}-${PV}"
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
