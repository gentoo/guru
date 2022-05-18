# Copyright 2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Sophisticated chroot/build/flash tool to develop and install postmarketOS."
HOMEPAGE="https://postmarketos.org/ https://pypi.org/project/pmbootstrap/"
SRC_URI="https://files.pythonhosted.org/packages/2a/5a/e78a923b813ed508ca341ae5978c33f706503e3ac83ff9c6af6d0e0a24fe/pmbootstrap-1.36.0.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
