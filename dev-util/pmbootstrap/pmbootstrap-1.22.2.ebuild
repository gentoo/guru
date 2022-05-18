# Copyright 2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8} )

inherit distutils-r1

DESCRIPTION="Sophisticated chroot/build/flash tool to develop and install postmarketOS."
HOMEPAGE="https://postmarketos.org/ https://pypi.org/project/pmbootstrap/"
SRC_URI="https://files.pythonhosted.org/packages/0d/a2/d81791f15ce1f8fbb94dcf2c3b5ce7e11fd1ea4892657e4a6bc38df4aa0b/pmbootstrap-1.22.2.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
