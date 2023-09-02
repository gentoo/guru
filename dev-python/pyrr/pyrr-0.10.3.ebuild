# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A cross platform utility library for ModernGL"
HOMEPAGE="https://github.com/adamlwgriffiths/pyrr https://pypi.org/project/pyrr"
SRC_URI="https://github.com/adamlwgriffiths/pyrr/archive/refs/tags/${PV}.tar.gz -> v${PV}.gh.tar.gz"
S="${WORKDIR}/Pyrr-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	dev-python/multipledispatch[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	doc? (
		<dev-python/sphinx-8[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

python_compile() {
	distutils-r1_python_compile
	if use doc; then
		find "${S}/docs" -type f -exec sed -i 's/sphinx\.ext\.pngmath/sphinx\.ext\.imgmath/g' {} \;
		emake man -C docs
	fi
}

python_install() {
	distutils-r1_python_install
	use doc && doman "${S}/docs/build/man/pyrr.1"
}

distutils_enable_tests pytest
python_test() {
	local EPYTEST_DESELECT="tests/test_matrix44.py::test_matrix44::test_create_perspective_projection_matrix_dtype"
	find "${S}/tests" -iname "*.py" -exec sed -i \
		-e 's/np\.float/float/g' \
		-e 's/float32/np\.float32/g' \
		-e 's/np\.int/int/g' \
		-e 's/int16/np\.int16/g' \
		{} \;
	epytest "${S}/tests" || die "Tests failed with ${EPYTHON}"
}
