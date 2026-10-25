# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature verify-sig xdg

DESCRIPTION="Simple Qt archive manager"
HOMEPAGE="https://github.com/tsujan/Arqiver"
SRC_URI="
	https://github.com/tsujan/Arqiver/releases/download/V${PV}/${P^}.tar.xz
	verify-sig? ( https://github.com/tsujan/Arqiver/releases/download/V${PV}/${P^}.tar.xz.asc )
"
S="${WORKDIR}/${P^}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,widgets]
	dev-qt/qtsvg:6
"
RDEPEND="
	${DEPEND}
	app-arch/libarchive
"
BDEPEND="
	dev-qt/qttools:6[linguist]
	verify-sig? ( sec-keys/openpgp-keys-tsujan )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/tsujan.asc"

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "7Zip archives" app-arch/7zip
}
