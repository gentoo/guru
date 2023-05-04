# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Applies STAT information from a Stylespace to a variable font"
HOMEPAGE="
	https://pypi.org/project/statmake/
	https://github.com/daltonmaag/statmake
"
SRC_URI="https://github.com/daltonmaag/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/attrs-21.3[${PYTHON_USEDEP}]
	>=dev-python/cattrs-22.2[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.11[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/ufo2ft-2.7[${PYTHON_USEDEP}]
		>=dev-python/ufoLib2-0.4[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
