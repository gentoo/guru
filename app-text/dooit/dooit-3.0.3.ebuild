# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A TUI todo manager"
HOMEPAGE="https://github.com/kraanzu/dooit https://pipy.org/project/dooit"
SRC_URI="https://github.com/kraanzu/dooit/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		=dev-python/pytest-asyncio-0.24*[${PYTHON_USEDEP}]
		~dev-python/Faker-30.8.2[${PYTHON_USEDEP}]
	)
"

RDEPEND="
	=dev-python/pyperclip-1.9*[${PYTHON_USEDEP}]
	=dev-python/pyyaml-6*[${PYTHON_USEDEP}]
	=dev-python/tzlocal-5.2*[${PYTHON_USEDEP}]
	=dev-python/textual-0.85*[${PYTHON_USEDEP}]
	=dev-python/python-dateutil-2.9*[${PYTHON_USEDEP}]
	~dev-python/sqlalchemy-2.0.36[${PYTHON_USEDEP}]
	~dev-python/platformdirs-4.3.6[${PYTHON_USEDEP}]
	~dev-python/click-8.1.7[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest
