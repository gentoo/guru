# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="Package to compile a fragment of Python source code to a corresponding LaTeX expression"
HOMEPAGE="
	https://pypi.org/project/latexify-py/
	https://github.com/google/latexify_py
"
# not really sure how -post1 should be handled
SRC_URI="https://github.com/google/latexify_py/archive/refs/tags/v0.4.3-post1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/latexify_py-0.4.3-post1"

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

