# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A library for piecewise linear interpolation in multiple dimensions"
HOMEPAGE="https://github.com/LettError/MutatorMath"
SRC_URI="https://github.com/LettError/MutatorMath/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-python/defcon[${PYTHON_USEDEP}]
	dev-python/fontMath[${PYTHON_USEDEP}]
	>=dev-python/fonttools-3.32[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/unicodedata2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py
