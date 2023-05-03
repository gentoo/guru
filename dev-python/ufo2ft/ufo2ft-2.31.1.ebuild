# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="A bridge from UFOs to FontTools"
HOMEPAGE="
	https://pypi.org/project/ufo2ft/
	https://github.com/googlefonts/ufo2ft
"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/cffsubr-0.2.8[${PYTHON_USEDEP}]
	>=dev-python/cu2qu-1.6.7[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.39.2[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/compreffor[${PYTHON_USEDEP}]
		dev-python/defcon[${PYTHON_USEDEP}]
		dev-python/skia-pathops[${PYTHON_USEDEP}]
		dev-python/ufoLib2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "compreffor support" dev-python/compreffor
	optfeature "pathops support" dev-python/skia-pathops
}
