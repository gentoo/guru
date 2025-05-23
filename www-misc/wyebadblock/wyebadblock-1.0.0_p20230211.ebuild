# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An adblock extension for wyeb, also webkit2gtk browsers."
HOMEPAGE="https://github.com/jun7/wyebadblock"
MY_COMMIT="529a5eedafacca9cd4ba78bf15d3a2bb565b821a"
SRC_URI="https://github.com/jun7/wyebadblock/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+:3
	net-libs/webkit-gtk:4.1
	dev-libs/glib:2
"
RDEPEND="${DEPEND}"

src_compile() {
	emake WEBKITVER=4.1
}

pkg_postinst() {
	ewarn "To use wyebadblock, you must first download and copy the easylist.txt file into ~/.config/wyebadblock/"
}
