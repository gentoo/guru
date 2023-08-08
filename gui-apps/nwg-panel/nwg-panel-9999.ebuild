# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

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
