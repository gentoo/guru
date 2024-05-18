# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="A python library for decision tree visualization and model interpretation"
HOMEPAGE="
	https://github.com/parrt/dtreeviz
	https://pypi.org/project/dtreeviz/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Tests are either not packaged properly
# Or have dependencies which aren't package in ::gentoo or ::guru
RESTRICT="test"

RDEPEND="
	>=dev-python/graphviz-0.9
	dev-python/pandas
	dev-python/numpy
	dev-python/scikit-learn
	dev-python/matplotlib
	dev-python/colour
"

distutils_enable_tests pytest
