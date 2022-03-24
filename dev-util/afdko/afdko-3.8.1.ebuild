# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Adobe Font Development Kit for OpenType"
HOMEPAGE="
	https://adobe-type-tools.github.io/afdko/
	https://github.com/adobe-type-tools/afdko
"
SRC_URI="https://github.com/adobe-type-tools/afdko/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

#lxml, unicodedata2, fs, brotli, brotlicffi, zopfli, fontpens are indirect dependencies
RDEPEND="
	>=dev-python/lxml-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=app-arch/brotli-1.0.1[python,${PYTHON_USEDEP}]
	>=dev-python/brotlicffi-0.8.0[${PYTHON_USEDEP}]
	>=app-arch/zopfli-0.1.4
	dev-python/fontPens[${PYTHON_USEDEP}]

	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.8.1[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.26.2[${PYTHON_USEDEP}]
	>=dev-util/psautohint-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.62.2[${PYTHON_USEDEP}]
	>=dev-python/ufoNormalizer-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/ufoProcessor-1.9.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/cython-0.29.5[${PYTHON_USEDEP}]
	>=dev-python/scikit-build-0.11.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools_scm-3.2.0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-util/ninja
	dev-util/cmake
"

DOCS=( {README,NEWS}.md docs )

PATCHES=( "${FILESDIR}/${PN}-3.6.2-_get_scripts-to-data_files.patch" )

distutils_enable_tests pytest

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
}

python_prepare_all() {
	rm docs/*.{yml,plist} || die
	distutils-r1_python_prepare_all
}

python_test() {
	local -x PYTHONPATH="${S}/python:${PYTHONPATH}"
	local -x PATH="${BUILD_DIR}/test/scripts:${S}/c/build_all:${PATH}"
	distutils_install_for_testing
	epytest -vv || die
}
