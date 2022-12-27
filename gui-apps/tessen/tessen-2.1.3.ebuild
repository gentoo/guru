# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="an interactive menu to autotype and copy pass and gopass data"
HOMEPAGE="https://github.com/ayushnix/tessen"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ayushnix/${PN}.git"
else
	SRC_URI="https://github.com/ayushnix/tessen/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+pass gopass bemenu wofi rofi"

REQUIRED_USE="|| ( pass gopass )"

DEPEND="app-text/scdoc"
RDEPEND="${DEPEND}
	pass? ( app-admin/pass )
	gopass? ( app-admin/gopass )"
BDEPEND=""

pkg_postinst() {
	optfeature "autotype support" gui-apps/wtype
	optfeature "clipboard support" gui-apps/wl-clipboard
	optfeature "URL opening support" x11-misc/xdg-utils
	optfeature "OTP support" app-admin/pass-otp
	optfeature "notifications support" x11-libs/libnotify
}
