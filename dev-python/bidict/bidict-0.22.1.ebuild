# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="The bidirectional mapping library for Python"
HOMEPAGE="
	https://pypi.org/project/bidict/
	https://github.com/jab/bidict
"
SRC_URI="https://github.com/jab/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/sortedcontainers[${PYTHON_USEDEP}]
		dev-python/sortedcollections[${PYTHON_USEDEP}]
	)
"

DOCS=( {CHANGELOG,README,SECURITY}.rst )

EPYTEST_IGNORE=( tests/test_microbenchmarks.py )

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/furo

src_prepare() {
	distutils-r1_src_prepare

	sed -i pytest.ini \
		-e "/--numprocesses/d" \
		-e "/--benchmark/d" || die
}
