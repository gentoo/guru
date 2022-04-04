# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="an interactive menu to autotype and copy pass and gopass data"
HOMEPAGE="https://github.com/ayushnix/tessen"
SRC_URI="https://github.com/ayushnix/tessen/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+pass gopass dmenu bemenu wofi rofi"

REQUIRED_USE="|| ( pass gopass )
	|| ( dmenu bemenu wofi rofi )"

DEPEND=""
RDEPEND="${DEPEND}
	dmenu? ( x11-misc/dmenu )
	bemenu? ( dev-libs/bemenu )
	wofi? ( gui-apps/wofi )
	rofi? ( x11-misc/rofi )
	pass? ( app-admin/pass )
	gopass? ( app-admin/gopass )"
BDEPEND=""
