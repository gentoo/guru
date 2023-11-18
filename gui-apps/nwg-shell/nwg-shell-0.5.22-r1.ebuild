# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

SRC_URI="https://github.com/nwg-piotr/nwg-shell/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="meta-package for the nwg-shell project"
HOMEPAGE="https://github.com/nwg-piotr/nwg-shell"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	app-misc/gopsuinfo
	app-misc/nwg-look
	gui-apps/azote
	gui-apps/nwg-bar
	gui-apps/nwg-displays
	|| ( gui-apps/nwg-dock gui-apps/nwg-dock-hyprland )
	gui-apps/nwg-drawer
	gui-apps/nwg-menu
	gui-apps/nwg-panel
	gui-apps/nwg-shell-config
"
DEPEND="${RDEPEND}"

python_install_all() {
	default
	dobin scripts/*
}

pkg_postinst() {
	elog "To install nwg-shell for the current user, run"
	elog "nwg-shell-installer -w (for sway) or"
	elog "nwg-shell-installer -w -hypr (for hyprland)"
}
