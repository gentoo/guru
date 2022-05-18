# Copyright 2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Sophisticated chroot/build/flash tool to develop and install postmarketOS."
HOMEPAGE="https://postmarketos.org/ https://pypi.org/project/pmbootstrap/"
SRC_URI="https://files.pythonhosted.org/packages/7c/6a/6984b3668c6a1c60e569bd5159294cacb5bff8358b8aed8c37ffdf4aa837/pmbootstrap-1.43.0.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="app-admin/sudo"
