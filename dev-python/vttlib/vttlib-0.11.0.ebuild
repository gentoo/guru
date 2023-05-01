# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

MY_PN="vttLib"
MY_PV="${PV/_p/.post}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Dump, merge and compile Visual TrueType data in UFO3 with FontTools"
HOMEPAGE="
	https://github.com/daltonmaag/vttLib
	https://pypi.org/project/vttLib/
"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.zip"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/fonttools-4.10.2[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.7.1[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		>=dev-python/ufo2ft-2.14.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
