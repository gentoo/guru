# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/source-foundry/font-v/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Font version string reporting and modification library"
HOMEPAGE="https://github.com/source-foundry/font-v"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-4.17[${PYTHON_USEDEP}]
	>=dev-python/GitPython-3.1.11[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-vcs/git )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx_rtd_theme

python_test() {
	#it want a git repo
	git init || die
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git add . || die
	git commit -m 'init' || die

	#pure madness
	#https://github.com/source-foundry/font-v/blob/e6746e4a045c99e56af661918c96259b1f444ed4/tests/test_utilities.py#L34
	sed -e "s|\"font-v\"|\"${PWD##*/}\"|g" -i "tests/test_utilities.py" || die
	epytest -vv
}
