# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
MYPN="vttLib"
MYPV="${PV/_p/.post}"
MYP="${MYPN}-${MYPV}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Dump, merge and compile Visual TrueType data in UFO3 with FontTools"
HOMEPAGE="
	https://github.com/daltonmaag/vttLib
	https://pypi.org/project/vttlib
"
SRC_URI="mirror://pypi/${MYP:0:1}/${MYPN}/${MYP}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

#install_requires
RDEPEND="
	>=dev-python/fonttools-4.10.2[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.7.1[${PYTHON_USEDEP}]
"
#setup_requires
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		>=dev-python/ufo2ft-2.14.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="app-arch/unzip"
S="${WORKDIR}/${MYP}"

distutils_enable_tests pytest
