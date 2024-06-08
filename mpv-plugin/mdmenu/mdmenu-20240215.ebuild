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

	einfo "mdmenu does not set any keybindings by default."
	einfo "Customize ~~/input.conf according to the documentation "
	einfo "in order to set custom bindings."

	if use custom-cmd ; then
		ewarn "mdmenu has been installed without dmenu."
		ewarn "You will need to set \`cmd\` in ~~/script-opts/mdmenu.conf "
		ewarn "to a dmenu-compatible application for mdmenu to work."
		ewarn "Please refer to the documentation for more info."
	fi
}
