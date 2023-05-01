# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="c450c76af542761f6d806fbe9b10b93a9b013212"
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

DESCRIPTION="Python Implementation of the TrueSkill Algorithm"
HOMEPAGE="
	https://trueskill.org
	https://github.com/sublee/trueskill
	https://pypi.org/project/trueskill/
"
SRC_URI="https://github.com/sublee/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	test? (
		>=dev-python/almost-0.1.5[${PYTHON_USEDEP}]
		>=dev-python/mpmath-0.17[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

RESTRICT="!test? ( test )"

distutils_enable_tests setup.py
#docs require a py2 only sphinx theme
