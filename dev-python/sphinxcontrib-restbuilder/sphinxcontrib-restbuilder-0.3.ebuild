# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A Sphinx builder/writer to output reStructuredText (rst) files"
HOMEPAGE="
	https://github.com/sphinx-contrib/restbuilder
	https://pypi.org/project/sphinxcontrib-restbuilder
"
SRC_URI="https://github.com/sphinx-contrib/restbuilder/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/sphinxcontrib-/}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
