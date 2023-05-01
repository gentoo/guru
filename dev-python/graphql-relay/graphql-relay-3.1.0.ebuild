# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Relay library for graphql-core-next"
HOMEPAGE="https://github.com/graphql-python/graphql-relay-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/graphql-core[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-describe[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
