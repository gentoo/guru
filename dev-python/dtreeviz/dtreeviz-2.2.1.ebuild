# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="A python library for decision tree visualization and model interpretation"
HOMEPAGE="
	https://pypi.org/project/dtreeviz/
"
SRC_URI="https://github.com/parrt/dtreeviz/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/graphviz-0.9
	dev-python/pandas
	dev-python/numpy
	sci-libs/scikit-learn
	dev-python/matplotlib
	dev-python/colour
	dev-python/pytest
"

src_install() {
	distutils-r1_src_install
}
