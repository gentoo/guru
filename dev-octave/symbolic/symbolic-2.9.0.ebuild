# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit octaveforge python-single-r1

DESCRIPTION="Octave Symbolic Package using SymPy"
HOMEPAGE="https://octave.sourceforge.io/symbolic/index.html"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=sci-mathematics/octave-4.2.0
	$(python_gen_cond_dep '
		dev-python/mpmath[${PYTHON_USEDEP}]
		dev-python/sympy[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	sed -e "s|python = 'python3';|python = \'${EPYTHON}\';|g" -i inst/private/defaultpython.m || die
	octaveforge_src_prepare
}
