# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYPI_PN=${PN^}
PYTHON_COMPAT=(python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A linter for prose"
HOMEPAGE="
	https://proselint.com
	https://github.com/amperser/proselint/
	https://pypi.org/project/proselint/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( )

distutils_enable_tests pytest
