# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="sweet looking lockscreen for linux system"
HOMEPAGE="https://github.com/betterlockscreen/betterlockscreen"
SRC_URI="https://github.com/betterlockscreen/betterlockscreen/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-gfx/feh
	media-gfx/imagemagick
	sys-devel/bc
	x11-apps/xdpyinfo
	x11-apps/xrandr
	x11-apps/xrdb
	x11-apps/xset
	>=x11-misc/i3lock-color-2.13.3:=
"

PATCHES=( "${FILESDIR}/00-fix-betterlockscreen-path-in-unit.patch" )

src_install() {
	dobin betterlockscreen

	dodoc -r examples

	systemd_dounit system/betterlockscreen@.service
}

pkg_postinst() {
	elog 'Lockscreen when suspended(systemd service):'
	elog 'systemctl enable betterlockscreen@$USER'
	elog ''
	elog 'How to use:'
	elog '1. Updating image cache(required)'
	elog 'betterlockscreen -u "/path/to/img.jpg"'
	elog '2. Lockscreen'
	elog 'betterlockscreen -l dim '
}
