# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Read, write and generate UFOs with designspace data"
HOMEPAGE="
	https://pypi.org/project/ufoProcessor/
	https://github.com/LettError/ufoProcessor
"
SRC_URI="$(pypi_sdist_url --no-normalize ${PN} ${PV} .zip)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/MutatorMath-2.1.2[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.4.9[${PYTHON_USEDEP}]
	>=dev-python/fontParts-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/fonttools-3.32.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.0[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	test? ( dev-python/unicodedata2[${PYTHON_USEDEP}] )
"

distutils_enable_tests setup.py

python_test() {
	${EPYTHON} Tests/tests.py || die "Tests failed with ${EPYTHON}"
}
