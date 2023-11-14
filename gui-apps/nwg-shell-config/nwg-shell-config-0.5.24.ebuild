# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 xdg-utils

SRC_URI="https://github.com/nwg-piotr/nwg-shell-config/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="nwg-shell configuration utility"
HOMEPAGE="https://github.com/nwg-piotr/nwg-shell-config"
LICENSE="MIT"

SLOT="0"

RDEPEND="
	gui-apps/nwg-shell
	sci-geosciences/geopy
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	domenu nwg-shell-config.desktop
	doicon nwg-shell-config.svg
	doicon nwg-shell-update.svg
	doicon nwg-shell-translate.svg
	doicon nwg-update-noupdate.svg
	doicon nwg-update-available.svg
	doicon nwg-update-checking.svg
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
