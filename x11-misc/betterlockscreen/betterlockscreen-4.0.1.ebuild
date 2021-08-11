# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="sweet looking lockscreen for linux system"
HOMEPAGE="https://github.com/pavanjadhaw/betterlockscreen"

inherit systemd

if [[ "${PV}" == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="https://github.com/pavanjadhaw/betterlockscreen/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	media-gfx/feh
	media-gfx/imagemagick
	sys-devel/bc
	x11-apps/xdpyinfo
	x11-apps/xrandr
	>=x11-misc/i3lock-color-2.11:=
"
RDEPEND="${DEPEND}"

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
