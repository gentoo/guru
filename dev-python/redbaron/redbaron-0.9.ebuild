# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="A FST for python to make writing refactoring code a realistic task"
HOMEPAGE="https://redbaron.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/baron-0.7[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
"

python_test() {
	# Remove "__pycache__". Reason: unique basename
	rm -rfd "${S}"/tests/__pycache__ || die

	# Skip tests. Reason: calls fixture "red" directly
	rm "${S}"/tests/test_bounding_box.py || die

	pytest -v || die "Tests fail with ${EPYTHON}"
}
