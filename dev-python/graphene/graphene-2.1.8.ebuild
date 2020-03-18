# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="GraphQL Framework for Python"
HOMEPAGE="https://github.com/graphql-python/graphene"
SRC_URI="https://github.com/graphql-python/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# We need newer graphql-core
RESTRICT="test"

RDEPEND="
	dev-python/aniso8601[${PYTHON_USEDEP}]
	dev-python/graphql-core[${PYTHON_USEDEP}]
	dev-python/graphql-relay[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]"

DEPEND="test? (
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/promises[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/iso8601[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Package installs 'examples' package which is forbidden and likely a bug in the build system.
	rm -r examples || die

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
# ModuleNotFoundError: No module named 'sphinx_graphene_theme'
# There is a github, but no releases at the moment
#distutils_enable_sphinx docs
