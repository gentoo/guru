# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A cross platform utility library for ModernGL"
HOMEPAGE="https://github.com/adamlwgriffiths/pyrr https://pypi.org/project/pyrr"
SRC_URI="https://github.com/adamlwgriffiths/pyrr/archive/refs/tags/${PV}.tar.gz -> v${PV}.gh.tar.gz"
S="${WORKDIR}/Pyrr-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
BDEPEND="
	dev-python/multipledispatch[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"
DEPEND="${BDEPEND}"

python_compile() {
	distutils-r1_python_compile
	find ./ -type f -exec sed -i 's/sphinx.ext.pngmath/sphinx.ext.imgmath/g' {} \;
	emake man -C docs
}

python_install() {
	distutils-r1_python_install
	doman "${S}/docs/build/man/pyrr.1"
}

# The tests failed with `module 'numpy' has no attribute 'float'`
# distutils_enable_tests pytest
# python_test() {
#     cd "${T}" || die
#     epytest "${S}"/tests || die "Tests failed with ${EPYTHON}"
# }
