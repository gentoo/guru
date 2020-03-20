# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="sweet looking lockscreen for linux system"
HOMEPAGE="https://github.com/pavanjadhaw/betterlockscreen"

if [[ ${PV} == 9999 ]];then
	inherit git-r3 systemd
	EGIT_REPO_URI="${HOMEPAGE}"
else
	inherit systemd
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	>=x11-misc/i3lock-color-2.11:=
	media-gfx/imagemagick
	x11-apps/xdpyinfo
	x11-apps/xrandr
	sys-devel/bc
	media-gfx/feh
"
RDEPEND="${DEPEND}"

src_install(){
	dobin betterlockscreen

	dodoc -r examples

	if [[ $PV == 9999 ]] ; then
		systemd_dounit system/betterlockscreen@.service
	else
		systemd_dounit betterlockscreen@.service
	fi
}

pkg_postinst() {
	elog 'Lockscreen when suspended(systemd service):'
	elog 'systemctl enable betterlockscreen@$USER'
	elog ''
	elog 'How to use:'
	elog '1. Updating image cache(required)'
	elog 'betterlockscreen -u ~/Pictures'
	elog '2. Lockscreen'
	elog 'betterlockscreen -l dim '
}
