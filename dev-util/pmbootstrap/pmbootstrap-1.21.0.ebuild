# Copyright 2019 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11} )

inherit distutils-r1

DESCRIPTION="Sophisticated chroot/build/flash tool to develop and install postmarketOS."
HOMEPAGE="https://postmarketos.org/ https://pypi.org/project/pmbootstrap/"
SRC_URI="https://files.pythonhosted.org/packages/8c/48/17c6bb30d1f550aba75b198d216b6ab2827fdff59a15b68b85263f31fb6d/pmbootstrap-1.21.0.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
