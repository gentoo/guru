# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-plugin

DESCRIPTION="dmenu based selection menu for chapters, tracks, playlist etc"
HOMEPAGE="https://codeberg.org/NRK/mpv-toolbox"

SRC_URI="https://codeberg.org/NRK/mpv-toolbox/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpv-toolbox/${PN}"

LICENSE="GPL-3+"
KEYWORDS="~amd64"
IUSE="custom-cmd"

RDEPEND="
	>=media-video/mpv-0.36.0[lua]
	!custom-cmd? ( x11-misc/dmenu )
"

MPV_PLUGIN_FILES=( mdmenu.lua )
DOCS=( mdmenu.conf README.md )

pkg_postinst() {
	mpv-plugin_pkg_postinst
	if use custom-cmd ; then
		ewarn "mdmenu has been installed without a launcher."
		ewarn "You will need to configure \`cmd\` in script-opt "
		ewarn "to a dmenu-compatible app for mdmenu to work."
		ewarn "Please refer to the documents for more info."
	fi
}
