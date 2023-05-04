# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 optfeature pypi

DESCRIPTION="Compile fonts from sources (UFO, Glyphs) to binary (OpenType, TrueType)"
HOMEPAGE="
	https://pypi.org/project/fontmake/
	https://github.com/googlefonts/fontmake
"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

# fonttools[ufo]
#   - dev-python/fs
# fonttools[lxml]
#   - dev-python/lxml
# fonttools[unicode]
#   - dev-python/unicodedata2
# ufo2ft[compreffor]
#   - dev-python/compreffor
RDEPEND="
	>=dev-python/attrs-19[${PYTHON_USEDEP}]
	>=dev-python/compreffor-0.4.6[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.9.3[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.38.0[${PYTHON_USEDEP}]
	>=dev-python/fs-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/glyphsLib-6.1.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.2.4[${PYTHON_USEDEP}]
	>=dev-python/ufo2ft-2.27.0[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.13.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'>=dev-python/unicodedata2-15[${PYTHON_USEDEP}]' 3.10)
"
BDEPEND="
	app-arch/unzip
	test? (
		>=dev-python/ttfautohint-py-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/MutatorMath-3.0.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "autohint support" dev-python/ttfautohint-py
	optfeature "mutatormath support" dev-python/MutatorMath
	optfeature "pathops support" dev-python/skia-pathops
}
