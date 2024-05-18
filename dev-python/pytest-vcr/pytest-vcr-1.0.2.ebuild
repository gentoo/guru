# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517="setuptools"
inherit distutils-r1 docs

DESCRIPTION="Plugin for managing VCR.py cassettes"
HOMEPAGE="
	https://pypi.org/project/pytest-vcr/
	https://github.com/ktosiek/pytest-vcr
"
SRC_URI="https://github.com/ktosiek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/vcrpy[${PYTHON_USEDEP}]
"

DOCS=( docs README.rst )

EPYTEST_DESELECT=( tests/test_vcr.py::test_no_warnings )

distutils_enable_tests pytest

python_prepare_all() {
	# pytest.config was removed in >=dev-python/pytest-5.0
	sed "/pytest.config/d" -i tests/test_vcr.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	docs_compile
}
