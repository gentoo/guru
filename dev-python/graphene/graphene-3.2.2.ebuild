# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="GraphQL Framework for Python"
HOMEPAGE="
	https://graphene-python.org
	https://pypi.org/project/graphene/
	https://github.com/graphql-python/graphene
"
SRC_URI="https://github.com/graphql-python/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	doc? ( https://graphene-python.org/sphinx_graphene_theme.zip -> sphinx-${P}.zip )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aniso8601-8[${PYTHON_USEDEP}]
	>=dev-python/graphql-core-3.1[${PYTHON_USEDEP}]
	>=dev-python/graphql-relay-3.1[${PYTHON_USEDEP}]
"

BDEPEND="
	doc? ( app-arch/unzip )
	test? (
		dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/snapshottest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs

EPYTEST_DESELECT=(
	# need pytest-benchmark
	graphene/types/tests/test_objecttype.py::test_objecttype_container_benchmark
	graphene/types/tests/test_query.py::test_big_list_query_benchmark
	graphene/types/tests/test_query.py::test_big_list_query_compiled_query_benchmark
	graphene/types/tests/test_query.py::test_big_list_of_containers_query_benchmark
	graphene/types/tests/test_query.py::test_big_list_of_containers_multiple_fields_query_benchmark
	graphene/types/tests/test_query.py::test_big_list_of_containers_multiple_fields_custom_resolvers_query_benchmark
)

src_unpack() {
	unpack ${P}.gh.tar.gz

	if use doc; then
		cd "${S}"/docs || die
		unpack sphinx-${P}.zip
	fi
}

python_compile_all() {
	local -x PYTHONPATH="${S}/docs:${PYTHONPATH}"
	sphinx_compile_all
}
