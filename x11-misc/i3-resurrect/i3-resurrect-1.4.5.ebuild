# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

PYPI_NO_NORMALIZE=true # Without this - cannot fetch
inherit distutils-r1 pypi

DESCRIPTION="Saving and restoring i3 workspaces"
HOMEPAGE="
	https://github.com/JonnyHaystack/i3-resurrect
	https://pypi.org/project/i3-resurrect
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/i3ipc[${PYTHON_USEDEP}]
	dev-python/natsort[${PYTHON_USEDEP}]
	x11-wm/i3
"

pkg_postins() {
	elog "Documentation: https://github.com/JonnyHaystack/i3-resurrect?tab=readme-ov-file#usage"
	elog "Alternative software: x11-misc/i3-restore"
}
