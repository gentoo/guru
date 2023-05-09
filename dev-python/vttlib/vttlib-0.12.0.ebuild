# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="vttLib"
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Dump, merge and compile Visual TrueType data in UFO3 with FontTools"
HOMEPAGE="
	https://pypi.org/project/vttLib/
	https://github.com/daltonmaag/vttLib
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/fonttools-4.10.2[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.7.1[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	test? (
		>=dev-python/ufo2ft-2.14.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
