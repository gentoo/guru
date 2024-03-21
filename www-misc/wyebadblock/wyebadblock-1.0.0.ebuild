# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An adblock extension for wyeb, also webkit2gtk browsers."
HOMEPAGE="https://github.com/jun7/wyebadblock"
SRC_URI="https://github.com/jun7/wyebadblock/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+:3
	net-libs/webkit-gtk:4
	dev-libs/glib:2
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "To use wyebadblock, you must first download and copy the easylist.txt file into ~/.config/wyebadblock/"
}
