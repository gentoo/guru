# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/LettError/MutatorMath/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="A library for piecewise linear interpolation in multiple dimensions"
HOMEPAGE="https://github.com/LettError/MutatorMath"
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
