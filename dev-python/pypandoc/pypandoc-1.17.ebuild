# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Pypandoc provides a thin wrapper for pandoc, a universal document converter"
HOMEPAGE="https://github.com/JessicaTegner/pypandoc https://pypi.org/project/pypandoc"
SRC_URI="https://github.com/JessicaTegner/pypandoc/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS+=( examples README.md LICENSE )

RDEPEND="virtual/pandoc"
BDEPEND="
	test? (
		>=dev-python/pandocfilters-1.5.0[${PYTHON_USEDEP}]
		app-text/texlive-core
		dev-texlive/texlive-latex
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
	)
"

EPYTEST_DESELECT=(
	# Need internet
	tests/test_pypandoc.py::TestPypandoc::test_basic_conversion_from_http_url
)
distutils_enable_tests pytest
