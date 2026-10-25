# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
MY_PN="FoBiS"

inherit distutils-r1

DESCRIPTION="FoBiS.py, a Fortran Building System for poor men"
HOMEPAGE="
	https://szaghi.github.io/FoBiS/
	https://github.com/szaghi/FoBiS
	https://pypi.org/project/FoBiS.py/
"
SRC_URI="https://github.com/szaghi/FoBiS/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc graphviz"
RESTRICT="mirror"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-python/typer[${PYTHON_USEDEP}]
		graphviz? ( dev-python/graphviz[${PYTHON_USEDEP}] )
	')
"

EPYTEST_PLUGINS=( pytest-cov )
distutils_enable_tests pytest

src_prepare() {
	default
	# The tmp-path contains version of package to within sandbox envinroment.
	# Therefore the count(__version__) method catch an "AssertionError: assert 3 == 2"
	sed -i -e 's/assert out.count(__version__) == 2/assert out.count(__version__) == 3/' tests/test_ecosystem.py || die
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dodoc -r docs
}
