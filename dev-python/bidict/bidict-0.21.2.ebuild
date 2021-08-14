# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="The bidirectional mapping library for Python"
HOMEPAGE="https://github.com/jab/bidict https://pypi.org/project/bidict/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? (
	dev-python/hypothesis[${PYTHON_USEDEP}]
	dev-python/pytest-benchmark[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
	dev-python/sortedcollections[${PYTHON_USEDEP}]
)"

DOCS=( CHANGELOG.rst README.rst SECURITY.rst )

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/alabaster
