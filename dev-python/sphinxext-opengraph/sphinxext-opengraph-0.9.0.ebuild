# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

hash="e261d13676a53f1909ff38edd41a5d83df84dace2625b2fe9e8a679d4ef3"

DESCRIPTION="Sphinx extension to generate unique OpenGraph metadata"
HOMEPAGE="https://github.com/wpilibsuite/sphinxext-opengraph"
SRC_URI="https://files.pythonhosted.org/packages/e7/b0/${hash}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	>=dev-python/sphinx-4.0[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
"
BDEPEND="
	doc? (
		media-fonts/roboto
		dev-python/furo[${PYTHON_USEDEP}]
		dev-python/myst-parser[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
	)
	test? ( dev-python/beautifulsoup4[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_compile_all() {
	use doc && emake -C docs man
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && doman "${S}/docs/build/man/${PN}.1"
}
