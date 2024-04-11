# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Pypandoc provides a thin wrapper for pandoc, a universal document converter"
HOMEPAGE="https://github.com/JessicaTegner/pypandoc https://pypi.org/project/pypandoc"
SRC_URI="https://github.com/JessicaTegner/pypandoc/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="virtual/pandoc"
BDEPEND="
	test? (
		>=dev-python/pandocfilters-1.5.0[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		app-text/texlive-core
		dev-texlive/texlive-latex
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
	)
"

EPYTEST_DESELECT=(
	tests.py::TestPypandoc::test_basic_conversion_from_http_url
	tests.py::TestPypandoc::test_pdf_conversion
)
python_test() {
	epytest tests.py
}
