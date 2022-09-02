# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..11} pypy3 )

inherit distutils-r1

DESCRIPTION="KaTeX Sphinx extension for rendering of math in HTML pages"
HOMEPAGE="https://github.com/hagenw/sphinxcontrib-katex"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-4.5.0-r1[${PYTHON_USEDEP}]"

DOCS=()

distutils_enable_sphinx docs

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
