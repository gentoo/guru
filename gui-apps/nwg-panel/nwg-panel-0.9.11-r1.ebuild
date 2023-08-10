# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit desktop distutils-r1 systemd xdg-utils

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-panel.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-panel/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK3-based panel for sway and Hyprland Wayland compositors"
HOMEPAGE="https://github.com/nwg-piotr/nwg-panel"
LICENSE="MIT"
IUSE="systemd"

SLOT="0"

RDEPEND="
	x11-libs/gtk+:3
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/i3ipc[${PYTHON_USEDEP}]
	dev-python/dasbus[${PYTHON_USEDEP}]
	gui-apps/nwg-icon-picker
	media-sound/playerctl
	gui-libs/gtk-layer-shell
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	domenu nwg-panel-config.desktop
	domenu nwg-processes.desktop
	doicon nwg-panel.svg
	doicon nwg-processes.svg
	doicon nwg-shell.svg
	if use systemd; then
		systemd_dounit nwg-panel.service
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
