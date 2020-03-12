# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A python library used to interact with Git repositories"
HOMEPAGE="https://github.com/gitpython-developers/GitPython"
SRC_URI="https://github.com/gitpython-developers/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test" # only works inside upstream git repo

RDEPEND="dev-python/gitdb[${PYTHON_USEDEP}]"

BDEPEND="test? ( dev-python/ddt[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/sphinx_rtd_theme

python_test() {
	cd "${S}" || die
	git init || die
	git config user.email "you@example.com" || die
	git config user.name "Your Name" || die
	git add -A || die
	git commit -q -m ".." || die

	pytest -vv || die "Tests fail with ${EPYTHON}"
}
