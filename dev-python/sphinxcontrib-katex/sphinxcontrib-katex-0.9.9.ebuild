# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="KaTeX Sphinx extension for rendering of math in HTML pages"
HOMEPAGE="https://github.com/hagenw/sphinxcontrib-katex"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/sphinx-4.5.0-r1[${PYTHON_USEDEP}]"

DOCS=()

distutils_enable_sphinx docs \
	dev-python/insipid-sphinx-theme

src_prepare() {
	default
	sed -i -e 's/license_file/license_files/' setup.cfg || die
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
