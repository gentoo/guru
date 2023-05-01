# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Bezier curve manipulation library"
HOMEPAGE="
	https://pypi.org/project/beziers/
	https://github.com/simoncozens/beziers.py
"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="dev-python/pyclipper[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/dotmap[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-0.4.0-no-install-tests.patch" )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "alpha_shape support" "dev-python/numpy dev-python/scipy dev-python/shapely"
	optfeature "brush support" dev-python/shapely
	optfeature "pen protocol support" dev-python/fonttools
	optfeature "plot support" dev-python/matplotlib
}
