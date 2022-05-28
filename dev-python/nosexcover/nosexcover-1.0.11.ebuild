# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Extends nose.plugins.cover to add Cobertura-style XML reports"
HOMEPAGE="
	https://github.com/cmheisel/nose-xcover
	https://pypi.org/project/nosexcover/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/nose[${PYTHON_USEDEP}]
	>=dev-python/coverage-3.4[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

distutils_enable_tests nose
