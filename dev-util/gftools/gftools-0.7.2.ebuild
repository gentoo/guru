# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="e33ccf3515cc5b8005a3a50b4163663623649d20"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="
	https://github.com/googlefonts/gftools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/schriftgestalt/GlyphsInfo/archive/${COMMIT}.tar.gz -> GlyphsInfo-${COMMIT}.tar.gz
"
KEYWORDS="~amd64"
DESCRIPTION="Miscellaneous tools for working with the Google Fonts collection"
HOMEPAGE="https://github.com/googlefonts/gftools"
LICENSE="Apache-2.0"
SLOT="0"

RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="
	$(python_gen_cond_dep '
		app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/absl-py[${PYTHON_USEDEP}]
		dev-python/babelfont[${PYTHON_USEDEP}]
		dev-python/browserstack-local-python[${PYTHON_USEDEP}]
		dev-python/fonttools[${PYTHON_USEDEP}]
		dev-python/glyphsLib[${PYTHON_USEDEP}]
		dev-python/ots-python[${PYTHON_USEDEP}]
		dev-python/protobuf-python[${PYTHON_USEDEP}]
		dev-python/pybrowserstack-screenshots[${PYTHON_USEDEP}]
		dev-python/pygit2[${PYTHON_USEDEP}]
		dev-python/PyGithub[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/statmake[${PYTHON_USEDEP}]
		dev-python/strictyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		dev-python/ttfautohint-py[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
		dev-python/vttlib[${PYTHON_USEDEP}]
		dev-util/fontmake[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(python_gen_cond_dep '
		dev-python/setuptools_scm[${PYTHON_USEDEP}]
	')
	test? (
		$(python_gen_cond_dep '
			dev-python/tabulate[${PYTHON_USEDEP}]
			media-gfx/fontforge[python,${PYTHON_SINGLE_USEDEP}]
		')
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-setup.diff"
	"${FILESDIR}/${PN}-tests.diff"
)

distutils_enable_tests pytest

python_prepare_all() {
	mv "${WORKDIR}/GlyphsInfo"/*.xml "Lib/${PN}/util/GlyphsInfo"
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV/_p/.post}"
	distutils-r1_python_prepare_all
}

python_test() {
	local -x PYTHONPATH="${BUILD_DIR}/lib:${PYTHONPATH}"
	local -x PATH="${S}:${PATH}"
	distutils_install_for_testing
	epytest -vv
}
