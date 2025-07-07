# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Console-based GLSL live-coding viewer"
HOMEPAGE="https://github.com/patriciogonzalezvivo/glslViewer"
EGIT_REPO_URI="https://github.com/patriciogonzalezvivo/glslViewer.git"
EGIT_COMMIT="7eb6254cb4cedf03f1c78653f90905fe0c3b48fb"

LICENSE="BSD"
SLOT="0"
IUSE="ffmpeg xvfb"

DEPEND="
	media-libs/glu
	sys-libs/ncurses
	ffmpeg? (
		media-video/ffmpeg
	)
	xvfb? (
		x11-base/xorg-server[xvfb]
	)
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0001-Removed-unsafe-post-install-MIME-and-desktop-databas.patch"
	"${FILESDIR}/0002-Install-libvera.so-to-machine.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_EXE_LINKER_FLAGS="-ltinfo"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md
}

pkg_postinst() {
	xdg-icon-resource forceupdate || die
	update-mime-database /usr/share/mime || die
	update-desktop-database /usr/share/applications || die
}

pkg_postrm() {
	update-mime-database /usr/share/mime || die
	update-desktop-database /usr/share/applications || die
}
