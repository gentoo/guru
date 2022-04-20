# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1 optfeature

DESCRIPTION="A wrapper for several Python libraries to compile fonts from sources"
HOMEPAGE="https://github.com/googlefonts/fontmake"
SRC_URI="https://github.com/googlefonts/fontmake/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

# lxml, compreffor and unicodedata2 are an indirect dependency
RDEPEND="
	>=dev-python/fonttools-4.32.0[${PYTHON_USEDEP}]
	>=dev-python/glyphsLib-6.0.4[${PYTHON_USEDEP}]
	>=dev-python/ufo2ft-2.27.0[${PYTHON_USEDEP}]
	>=dev-python/fontMath-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/ufoLib2-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-19[${PYTHON_USEDEP}]

	>=dev-python/lxml-4.2.4[${PYTHON_USEDEP}]
	dev-python/compreffor[${PYTHON_USEDEP}]
	>=dev-python/unicodedata2-14[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		media-gfx/fontdiff
		dev-python/mock[${PYTHON_USEDEP}]
	)
"
PATCHES=(
	"${FILESDIR}/defaults.diff"
)

distutils_enable_tests pytest

pkg_setup() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
}

pkg_postinst() {
	optfeature "mutatormath support" >=dev-python/MutatorMath-3.0.1[${PYTHON_USEDEP}]
	optfeature "pathops support" >=dev-python/skia-pathops-0.3.0[${PYTHON_USEDEP}]
	optfeature "autohint support" >=dev-python/ttfautohint-0.5.0[${PYTHON_USEDEP}]
}
