# Copyright 2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Sophisticated chroot/build/flash tool to develop and install postmarketOS."
HOMEPAGE="https://postmarketos.org/ https://pypi.org/project/pmbootstrap/"
SRC_URI="https://files.pythonhosted.org/packages/9f/a2/344811f2b59cdf0b092a3b1e2302dc012b449b412b59859af7bfa5fee5b9/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
