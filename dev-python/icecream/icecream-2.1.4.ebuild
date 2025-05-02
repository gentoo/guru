# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://github.com/gruns/icecream https://pypi.org/project/icecream/"
SRC_URI="https://github.com/gruns/icecream/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/executing-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/asttokens-2.0.1[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

python_prepare_all() {
	# Install tests package otherwise
	sed -i 's/find_packages()/find_packages(exclude=["tests", "tests.*"])/' "${S}"/setup.py || die
	distutils-r1_python_prepare_all
}
