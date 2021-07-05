# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} pypy3 )

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
IUSE="test"

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

PROPERTIES="test_network"
RESTRICT="test"

python_test() {
	"${EPYTHON}" tests.py || die "Tests fail with ${EPYTHON}"
}
