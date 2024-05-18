# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="Annotate Python source code to get LaTeX expressions"
HOMEPAGE="
	https://pypi.org/project/latexify-py/
	https://github.com/google/latexify_py
"

# upstream package is called latexify-py (on pypi), but their filename is called latexify_py
# we're using $(ver_cut 1-3) because of this specific postfix version, akin to -r1. remove in next versions
SRC_URI="https://github.com/google/latexify_py/archive/refs/tags/v$(ver_cut 1-3)-post1.tar.gz -> ${PN/-/_}-$(ver_cut 1-3)-post1.gh.tar.gz"
S="${WORKDIR}/${PN/-/_}-$(ver_cut 1-3)-post1"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/dill[${PYTHON_USEDEP}]
"
DEPEND="${PYTHON_DEPS}"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
}
