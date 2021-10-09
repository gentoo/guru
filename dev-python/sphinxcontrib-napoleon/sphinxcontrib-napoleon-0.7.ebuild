# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Allow a different format in dosctrings for better clarity"
HOMEPAGE="https://sphinxcontrib-napoleon.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/pockets[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
