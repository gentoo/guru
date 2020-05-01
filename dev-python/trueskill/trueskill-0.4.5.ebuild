# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Python Implementation of the TrueSkill, Glicko and Elo Ranking Algorithms"
HOMEPAGE="
	https://trueskill.org
	https://github.com/sublee/trueskill
	https://pypi.org/project/trueskill
"
SRC_URI="https://github.com/sublee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND=""
DEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	test? (
		>=dev-python/almost-0.1.5[${PYTHON_USEDEP}]
		>=dev-python/mpmath-0.17[${PYTHON_USEDEP}]
		<dev-python/pytest-4.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py
#docs require a py2 only sphinx theme
