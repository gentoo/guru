# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Plugin for pytest that shows failures and errors instantly"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-instafail
	https://pypi.org/project/pytest-instafail
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

RDEPEND="
	>=dev-python/pytest-2.9[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
