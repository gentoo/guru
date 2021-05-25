# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Tool to check the completeness of MANIFEST.in for Python packages"
HOMEPAGE="
	https://github.com/mgedmin/check-manifest
	https://pypi.org/project/check-manifest
"
SRC_URI="https://github.com/mgedmin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/toml[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	epytest \
		--deselect tests.py::Tests::test_build_sdist_pep517_isolated \
		--deselect tests.py::Tests::test_build_sdist_pep517_no_isolation
}
