# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Decompilation of 3D Pinball for Windows - Space Cadet"
HOMEPAGE="https://github.com/k4zmu2a/SpaceCadetPinball"
SRC_URI="https://github.com/k4zmu2a/${PN}/archive/refs/tags/Release_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer[midi]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-Release_${PV}"

pkg_postinst(){
	ewarn "This game is distributed without the data files."
	ewarn "To play, copy the original DAT and SOUND files from a Windows or"
	ewarn 'Full Tilt! installation and place them in $XDG_DATA_HOME/'"${PN}/"
	ewarn "(usually: ~/.local/share/${PN}/)"

	xdg_pkg_postinst
}
