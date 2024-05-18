# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Apache2 licensed Python sorted collections library"
HOMEPAGE="
	https://pypi.org/project/sortedcollections/
	https://github.com/grantjenks/python-sortedcollections
"
SRC_URI="https://github.com/grantjenks/python-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/sortedcontainers[${PYTHON_USEDEP}]"
BDEPEND="doc? ( ${RDEPEND} )"

distutils_enable_tests pytest
distutils_enable_sphinx docs

src_prepare() {
	# breaks pytest
	rm tox.ini || die

	distutils-r1_src_prepare
}

python_test() {
	epytest --doctest-glob="*.rst"
}
