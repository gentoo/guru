# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="poetry"
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Pypandoc provides a thin wrapper for pandoc, a universal document converter"
HOMEPAGE="https://github.com/JessicaTegner/pypandoc https://pypi.org/project/pypandoc"
SRC_URI="https://github.com/JessicaTegner/pypandoc/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"

RDEPEND="app-text/pandoc"
BDEPEND="
	test? (
		>=dev-python/pandocfilters-1.5.0[${PYTHON_USEDEP}]
		app-text/texlive-core
		dev-texlive/texlive-latex
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
	)
"

python_test() {
	# This test wants internet access
	sed -i -e 's:test_basic_conversion_from_http_url:_&:' tests.py || die
	# This one fails for no reason. When not in sandbox mode, the conversion is made without problems
	sed -i -e 's:test_conversion_with_data_files:_&:' tests.py || die

	"${EPYTHON}" tests.py || die "Tests fail with ${EPYTHON}"
}
