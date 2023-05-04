# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

ANTLR_PV="4.9.3"
ANTLR_P="antlr-cpp-${ANTLR_PV}"
DESCRIPTION="Adobe Font Development Kit for OpenType"
HOMEPAGE="
	https://adobe-type-tools.github.io/afdko/
	https://pypi.org/project/afdko/
	https://github.com/adobe-type-tools/afdko
"
SRC_URI+=" https://www.antlr.org/download/antlr4-cpp-runtime-${ANTLR_PV}-source.zip -> ${ANTLR_P}.zip"

KEYWORDS="~amd64"
LICENSE="Apache-2.0 BSD"
SLOT="0"

# requirements.txt
# ================
#
# fontTools[unicode]
#   - dev-python/unicodedata2
# fontTools[woff]
#   - app-arch/brotli[python] (for CPython)
#   - dev-python/brotlicffi (for PyPy3)
#   - dev-python/zopfli
# fontTools[lxml]
#   - dev-python/lxml
# fontTools[ufo]
#   - dev-python/fs
#
# defcon[lxml]
#   - dev-python/lxml
# defcon[pens]
#   - dev-python/fontPens
#
# Blockers
# ========
#
# app-i18n/transifex-client: file collision
DEPEND="dev-libs/libxml2:2"
RDEPEND="${DEPEND}
	>=app-arch/brotli-1.0.1[python,${PYTHON_USEDEP}]
	>=dev-python/booleanOperations-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.10.2[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.9.3[${PYTHON_USEDEP}]
	>=dev-python/fontPens-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.38.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.9.2[${PYTHON_USEDEP}]
	>=dev-python/psautohint-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.64.1[${PYTHON_USEDEP}]
	>=dev-python/ufoNormalizer-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/ufoProcessor-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/zopfli-0.1.4[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'>=dev-python/unicodedata2-14.0.0[${PYTHON_USEDEP}]' \
		python3_{9..10})
	!app-i18n/transifex-client
"
BDEPEND="
	app-arch/unzip
	>=dev-python/scikit-build-0.11.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-3.2.0[${PYTHON_USEDEP}]
"

DOCS=( {README,NEWS}.md docs )

PATCHES=(
	"${FILESDIR}/${PN}-3.9.5-no-cmake-ninja-deps.patch"
)

EEPYTEST_DESELECT=( tests/makeotf_test.py::test_writeOptionsFile )

distutils_enable_tests pytest

src_prepare() {
	rm docs/*.{yml,plist} || die

	distutils-r1_src_prepare
}

src_configure() {
	DISTUTILS_ARGS=( -DANTLR4_ZIP_REPOSITORY="${DISTDIR}/${ANTLR_P}.zip" )
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

	distutils-r1_src_configure
}
