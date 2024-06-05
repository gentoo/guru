# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Mobile and privacy friendly configuration for Firefox"
HOMEPAGE="https://gitlab.com/postmarketOS/mobile-config-firefox"
SRC_URI="https://gitlab.com/postmarketOS/mobile-config-firefox/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

PATCHES=(
	"${FILESDIR}"/0001-src-prefs.js-disable-sandbox-for-non-ESR.patch
	"${FILESDIR}"/disable-proton-ui.patch
)

src_install() {
	default
	mv "${D}"/usr/lib "${D}"/usr/lib64 || die
}

pkg_postinst() {
	elog "You will need to copy /etc/mobile-config-firefox/userChrome.css file to"
	elog "your firefox profile's chrome folder ~/.mozilla/firefox/XXXX/chrome/ "
	elog "to enable firefox mobile layout, you might need to create the chrome "
	elog "folder if it's not there"
}
