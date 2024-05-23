# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="libraries an common functions for the nwg-shell project"
HOMEPAGE="https://github.com/nwg-piotr/nwg-shell"
SRC_URI="https://github.com/nwg-piotr/nwg-shell/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-apps/grim
	gui-apps/swappy
	gui-apps/slurp
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
