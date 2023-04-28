# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=poetry
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Python port of GraphQL.js, the JavaScript reference implementation for GraphQL"
HOMEPAGE="
	https://pypi.org/project/graphql-core/
	https://github.com/graphql-python/graphql-core
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	$(python_gen_cond_dep \
		'dev-python/typing-extensions[${PYTHON_USEDEP}]' python3_9)
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-describe[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=( tests/benchmarks )

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

python_test() {
	if [[ ${EPYTHON} == "python3.11" ]]; then
		local EPYTEST_DESELECT=(
			tests/pyutils/test_is_awaitable.py::describe_is_awaitable::recognizes_an_old_style_coroutine
		)
	fi
	epytest
}
