# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="GraphQL-core is a Python port of GraphQL.js"
HOMEPAGE="
	https://github.com/graphql-python/graphql-core/
	https://pypi.org/project/graphql-core/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	<dev-python/setuptools-81[${PYTHON_USEDEP}]
	>=dev-python/setuptools-59[${PYTHON_USEDEP}]
"

EPYTEST_IGNORE=(
	# avoid pytest-benchmark
	"tests/benchmarks/"
)

EPYTEST_PLUGINS=( anyio pytest-asyncio pytest-describe pytest-timeout )
distutils_enable_tests pytest

python_test() {
	# avoid pytest-benchmark
	epytest -o addopts= tests
}
