# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi toolchain-funcs

MY_PN="FORD"
DESCRIPTION="FORD, automatic documentation generator for modern Fortran programs"
HOMEPAGE="https://github.com/Fortran-FOSS-Programmers/ford"
SRC_URI="$(pypi_sdist_url --no-normalize "${MY_PN^}" "${PV}")"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	>=dev-python/graphviz-0.20[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	>=dev-python/markdown-3.4[${PYTHON_USEDEP}]
	>=dev-python/markdown-include-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.12.0[${PYTHON_USEDEP}]
	dev-python/python-markdown-math[${PYTHON_USEDEP}]
	>=dev-python/toposort-1.7[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.64.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}_fix_setuptools_warnings.patch" )

DOCS=( CHANGELOG.md README.md )

distutils_enable_tests pytest

src_prepare() {
	default
	sed -i -e 's/"cpp /"'"$(tc-getCPP)"' /' ford/__init__.py || die # bug: 839300
}
