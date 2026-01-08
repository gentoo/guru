# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="A TUI todo manager"
HOMEPAGE="
	https://dooit-org.github.io/dooit/
	https://github.com/dooit-org/dooit
	https://pypi.org/project/dooit
"
SRC_URI="https://github.com/dooit-org/dooit/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )

BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		>=dev-python/textual-dev-1.7.0[${PYTHON_USEDEP}]
		>=dev-python/faker-37.8.0[${PYTHON_USEDEP}]
	)
"

RDEPEND="
	>=dev-python/pyperclip-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.9.0_p0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/textual-6.1.0[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-5.3.1[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0.43[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.8[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
