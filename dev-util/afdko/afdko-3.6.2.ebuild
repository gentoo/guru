# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Adobe Font Development Kit for OpenType"
HOMEPAGE="https://adobe-type-tools.github.io/afdko"
SRC_URI="https://github.com/adobe-type-tools/afdko/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" #too many failed tests

RDEPEND="
	>=dev-python/booleanOperations-0.9[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.6[${PYTHON_USEDEP}]
	dev-python/fontPens[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.21.1[${PYTHON_USEDEP}]
	>=dev-util/psautohint-2.3[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.58[${PYTHON_USEDEP}]
	>=dev-python/ufoNormalizer-0.5.3[${PYTHON_USEDEP}]
	>=dev-python/ufoProcessor-1.9[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

DOCS=( {README,NEWS}.md docs )

PATCHES=(
	"${FILESDIR}/${PN}-nowheel.diff"
	"${FILESDIR}/${P}-AR-fix.patch"
	"${FILESDIR}/${P}-relax-hard-pinning.patch"
	"${FILESDIR}/${P}-_get_scripts-to-data_files.patch"
)

distutils_enable_tests pytest

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
}

python_prepare_all() {
	rm docs/*.{yml,plist} || die
	distutils-r1_python_prepare_all
}

src_compile() {
	tc-export CC CPP AR
	local _d
	find -path '*/linux/gcc/release/Makefile' | while read _d; do
		emake -C "${_d%/Makefile}" XFLAGS="${CFLAGS}" || return
	done
	distutils-r1_src_compile
}

python_test() {
	local -x PYTHONPATH="${S}/python:${PYTHONPATH}"
	local -x PATH="${BUILD_DIR}/test/scripts:${S}/c/build_all:${PATH}"
	distutils_install_for_testing
	epytest -vv || die
}
