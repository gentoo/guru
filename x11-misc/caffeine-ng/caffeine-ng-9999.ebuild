# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1 gnome2-utils

DESCRIPTION="Aplication able to temporarily inhibit the screensaver."
HOMEPAGE="https://github.com/caffeine-ng/caffeine-ng"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${P}.tar.gz"
fi

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/pygobject:3
	>=dev-python/pyxdg-0.25
	dev-python/dbus-python
	>=dev-python/docopt-0.6.2
	>=dev-python/setproctitle-1.1.10
	dev-python/setuptools
	>=dev-python/wheel-0.29.0
	dev-python/setuptools_scm
	dev-libs/libappindicator:3
	x11-libs/gtk+:3
	x11-libs/libnotify
"
RDEPEND="${DEPEND}"

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_gconf_uninstall
	gnome2_schemas_update
}
