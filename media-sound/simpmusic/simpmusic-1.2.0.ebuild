# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="A cross-platform music app using YouTube Music for backend"
HOMEPAGE="https://simpmusic.org/"
SRC_URI="https://github.com/maxrave-dev/SimpMusic/releases/download/v${PV}/SimpMusic-x86_64.AppImage -> ${P}.AppImage"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Standard runtime dependencies for a Kotlin/Compose AppImage
RDEPEND="
	sys-fs/fuse:0
	sys-libs/zlib
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
"

# AppImages are pre-compiled and shouldn't be stripped or mirrored
RESTRICT="strip mirror"

src_unpack() {
	# Copy the AppImage from distfiles to the work directory
	cp "${DISTDIR}/${P}.AppImage" "${S}/${PN}" || die
	chmod +x "${S}/${PN}" || die
}

src_install() {
	# Install the binary into /opt
	exeinto "/opt/${PN}"
	doexe "${PN}"

	# Create symlink in /usr/bin for terminal access
	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}"

	# Create the desktop menu entry
	make_desktop_entry "${PN}" "SimpMusic" "" "AudioVideo;Music;"
}
