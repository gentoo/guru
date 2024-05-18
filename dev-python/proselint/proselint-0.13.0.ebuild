# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYPI_PN=${PN^}
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A linter for prose"
HOMEPAGE="
	https://github.com/amperser/proselint/
	https://pypi.org/project/proselint/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
