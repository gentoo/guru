# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 xdg-utils

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-clipman.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-clipman/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="nwg-shell clipboard manager - a GTK3-based GUI for cliphist"
HOMEPAGE="https://github.com/nwg-piotr/nwg-clipman"
LICENSE="MIT"

SLOT="0"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
	gui-libs/gtk-layer-shell[introspection]
	gui-apps/wl-clipboard
	app-misc/cliphist
	x11-misc/xdg-utils
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	domenu nwg-clipman.desktop
	doicon nwg-clipman.svg
	dodoc README.md
}

pkg_postinst() {
	xdg_desktop_database_update
	elog "To enable nwg-cliphist put this in your compisitors config:"
	elog "For sway:"
	elog "exec wl-paste --type text --watch cliphist store"
	elog "exec wl-paste --type image --watch cliphist store"
	elog "For hyprland:"
	elog "exec-once = wl-paste --type text --watch cliphist store"
	elog "exec-once = wl-paste --type image --watch cliphist store"
}

pkg_postrm() {
	xdg_desktop_database_update
}
