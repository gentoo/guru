# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Jupyter Sphinx Extensions"
HOMEPAGE="https://github.com/jupyter/jupyter-sphinx"
SRC_URI="https://github.com/jupyter/jupyter-sphinx/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-with-disclosure"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/sphinx-2[${PYTHON_USEDEP}]
	>=dev-python/ipywidgets-7.0.0[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	>=dev-python/nbconvert-5.5[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/matplotlib dev-python/alabaster
