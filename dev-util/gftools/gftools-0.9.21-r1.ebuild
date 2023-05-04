# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GLYPHSINFO_COMMIT="e33ccf3515cc5b8005a3a50b4163663623649d20"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 multibuild

DESCRIPTION="Miscellaneous tools for working with the Google Fonts collection"
HOMEPAGE="https://github.com/googlefonts/gftools"
SRC_URI="
	https://github.com/googlefonts/gftools/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/schriftgestalt/GlyphsInfo/archive/${GLYPHSINFO_COMMIT}.tar.gz -> GlyphsInfo.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0 MIT test? ( OFL )"
SLOT="0"

# ufolib2 is an indirect dependency
RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/axisregistry-0.2.0[${PYTHON_USEDEP}]
		app-arch/brotli[python,${PYTHON_USEDEP}]
		>=dev-python/browserstack-local-python-1.2.2[${PYTHON_USEDEP}]
		dev-python/PyGithub[${PYTHON_USEDEP}]
		dev-python/absl-py[${PYTHON_USEDEP}]
		dev-python/babelfont[${PYTHON_USEDEP}]
		>=dev-python/fontFeatures-1.6.2[${PYTHON_USEDEP}]
		dev-python/fonttools[${PYTHON_USEDEP}]
		>=dev-python/gflanguages-0.4.0[${PYTHON_USEDEP}]
		dev-python/glyphsLib[${PYTHON_USEDEP}]
		>=dev-python/glyphsets-0.2.1[${PYTHON_USEDEP}]
		dev-python/hyperglot[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/ots-python[${PYTHON_USEDEP}]
		dev-python/protobuf-python[${PYTHON_USEDEP}]
		>=dev-python/pybrowserstack-screenshots-0.1[${PYTHON_USEDEP}]
		dev-python/pygit2[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/skia-pathops[${PYTHON_USEDEP}]
		dev-python/statmake[${PYTHON_USEDEP}]
		dev-python/strictyaml[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/ttfautohint-py[${PYTHON_USEDEP}]
		dev-python/ufoLib2[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
		dev-python/vharfbuzz[${PYTHON_USEDEP}]
		dev-python/vttlib[${PYTHON_USEDEP}]
		>=dev-util/fontmake-3.3.0[${PYTHON_USEDEP}]
	')
"
DEPEND="
	${RDEPEND}
	$(python_gen_cond_dep '>=dev-python/setuptools-scm-4[${PYTHON_USEDEP}]')
"

RESTRICT="test"
PROPERTIES="test_network"

distutils_enable_tests pytest

python_prepare_all() {
	mv "${WORKDIR}/GlyphsInfo-${GLYPHSINFO_COMMIT}"/*.xml "Lib/gftools/util/GlyphsInfo" || die
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV/_p/.post}"
	distutils-r1_python_prepare_all
}

python_test() {
	local -x PYTHONPATH="${BUILD_DIR}/lib:${PYTHONPATH}"
	local -x PATH="${S}:${PATH}"
	distutils_install_for_testing
	epytest -vv
}
