# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Jupyter Sphinx Extensions"
HOMEPAGE="https://github.com/jupyter/jupyter-sphinx"
SRC_URI="https://github.com/jupyter/jupyter-sphinx/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/sphinx-2[${PYTHON_USEDEP}]
	>=dev-python/ipywidgets-7.0.0[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	>=dev-python/nbconvert-5.5[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/matplotlib dev-python/alabaster
