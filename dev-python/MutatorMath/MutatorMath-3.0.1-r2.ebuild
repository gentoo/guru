# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="A library for piecewise linear interpolation in multiple dimensions"
HOMEPAGE="
	https://pypi.org/project/MutatorMath/
	https://github.com/LettError/MutatorMath
"
SRC_URI="$(pypi_sdist_url --no-normalize ${PN} ${PV} .zip)"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-python/defcon[${PYTHON_USEDEP}]
	dev-python/fontMath[${PYTHON_USEDEP}]
	>=dev-python/fonttools-3.32[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	test? (
		>=dev-python/unicodedata2-15.0.0[${PYTHON_USEDEP}]
	)
"

DOCS=( Docs README.rst )

distutils_enable_tests setup.py
