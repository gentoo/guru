# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/k4zmu2a/SpaceCadetPinball.git"

inherit cmake git-r3 xdg

DESCRIPTION="Decompilation of 3D Pinball for Windows - Space Cadet"
HOMEPAGE="https://github.com/k4zmu2a/SpaceCadetPinball"

LICENSE="MIT"
SLOT="0"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer[midi]
"
RDEPEND="${DEPEND}"

pkg_postinst(){
	ewarn "This game is distributed without the data files."
	ewarn "To play, copy the original DAT and SOUND files from a Windows or"
	ewarn 'Full Tilt! installation and place them in $XDG_DATA_HOME/'"${PN}/"
	ewarn "(usually: ~/.local/share/${PN}/)"

	xdg_pkg_postinst
}
