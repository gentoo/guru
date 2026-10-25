# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Soho vibes for your mouse cursor"
HOMEPAGE="https://rosepinetheme.com"
SRC_URI="https://github.com/rose-pine/cursors/releases/download/v${PV}/BreezeX-RosePine-Linux.tar.xz -> ${P}.tar.xz https://github.com/rose-pine/cursors/releases/download/v${PV}/BreezeX-RosePineDawn-Linux.tar.xz -> ${PN}-dawn-${PV}.tar.xz"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto "/usr/share/icons"

	# copied from the x11-themes/catppuccin-cursors::guru ebuild
	for folder in * ; do
		if [[ -d "${folder}" ]]; then
			doins -r "${folder}"
		fi
	done
}
