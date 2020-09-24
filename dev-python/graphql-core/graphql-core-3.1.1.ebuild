# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="GraphQL for Python"
HOMEPAGE="https://github.com/graphql-python/graphql-core"
SRC_URI="https://github.com/graphql-python/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? (
	dev-python/pytest-benchmark[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx_rtd_theme
