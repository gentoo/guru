# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
inherit distutils-r1 pypi

DESCRIPTION="A bridge from UFOs to FontTool objects"
HOMEPAGE="
	https://github.com/googlefonts/ufo2ft
	https://pypi.org/project/ufo2ft/
"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/compreffor-0.5.1_p1[${PYTHON_USEDEP}]
	>=dev-python/cffsubr-0.2.9_p1[${PYTHON_USEDEP}]
	>=dev-python/cu2qu-1.6.7[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.29.1[${PYTHON_USEDEP}]
	>=dev-python/skia-pathops-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.13.1[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/glyphsLib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
