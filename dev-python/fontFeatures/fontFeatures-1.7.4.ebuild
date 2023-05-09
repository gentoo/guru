# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 optfeature pypi

DESCRIPTION="Python library for manipulating OpenType font features"
HOMEPAGE="
	https://pypi.org/project/fontFeatures/
	https://github.com/simoncozens/fontFeatures
"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

# Tests are also failing upstream
# https://github.com/simoncozens/fontFeatures/actions/runs/3677601386/jobs/6219782260
#RESTRICT="test"

RDEPEND="
	>=dev-python/beziers-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.28.0[${PYTHON_USEDEP}]
	dev-python/fs[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/youseedee-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/babelfont-3.0.0_alpha1[${PYTHON_USEDEP}]
	)
"
PDEPEND=">=dev-python/glyphtools-0.7.0[${PYTHON_USEDEP}]"

DOCS=( {CHANGES,NEW-FORMAT,README}.md )

EPYTEST_DESELECT=(
	tests/test_anchors.py::TestAnchors::test_markbase
	tests/test_chaining.py::TestChaining::test_ignore
	"tests/test_fea_parser.py::test_round_trip[mark_attachment]"
)

distutils_enable_tests pytest

python_test() {
	local -x CI=1
	epytest
}

pkg_postinst() {
	optfeature "shaper support" "dev-python/babelfont dev-python/youseedee"
}
