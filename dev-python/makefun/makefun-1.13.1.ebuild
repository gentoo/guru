# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-material"
inherit distutils-r1 docs

DESCRIPTION="Small library to dynamically create python functions"
HOMEPAGE="https://pypi.org/project/makefun/ https://github.com/smarie/python-makefun"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	sed "/pytest-runner/d" -i setup.cfg || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	docs_compile
}
