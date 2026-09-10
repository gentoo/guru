# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Enlighten Progress Bar for Python Console Apps"
HOMEPAGE="https://python-enlighten.readthedocs.io/"
SRC_URI="https://github.com/Rockhopper-Technologies/enlighten/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/blessed[${PYTHON_USEDEP}]
	dev-python/prefixed[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_install() {
	rm -rf "${BUILD_DIR}/install$(python_get_sitedir)/benchmarks" || die
	distutils-r1_python_install
}
