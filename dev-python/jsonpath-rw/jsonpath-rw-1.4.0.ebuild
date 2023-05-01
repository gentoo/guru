# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="python-${PN}"
PYTHON_COMPAT=( python3_10 pypy3 )

inherit distutils-r1

DESCRIPTION="A robust and significantly extended implementation of JSONPath for Python"
HOMEPAGE="
	https://github.com/kennknowles/python-jsonpath-rw
	https://pypi.org/project/jsonpath-rw/
"
SRC_URI="https://github.com/kennknowles/${MYPN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${REDEPEND}"
BDEPEND="
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

RESTRICT="!test? ( test )"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
