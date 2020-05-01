# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Pypandoc provides a thin wrapper for pandoc, a universal document converter"
HOMEPAGE="
	https://github.com/bebraw/pypandoc
	https://pypi.org/project/pypandoc/
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/pandoc
	dev-haskell/pandoc-citeproc
	dev-texlive/texlive-latex
"
DEPEND="
	${RDEPEND}
	>=dev-python/wheel-0.25.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

python_test() {
	# Skip tests. Wants: internet access
	sed -i -e 's:test_basic_conversion_from_http_url:_&:' tests.py || die
	# Skip tests. Wants: nonexistent font
	sed -i -e 's:test_pdf_conversion:_&:' tests.py || die

	"${EPYTHON}" tests.py || die "Tests fail with ${EPYTHON}"
}
