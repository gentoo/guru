# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Font version string reporting and modification library"
HOMEPAGE="https://github.com/source-foundry/font-v"
SRC_URI="https://github.com/source-foundry/font-v/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-vcs/git )"

distutils_enable_tests --install pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

src_test() {
	#it want a git repo
	git init || die
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die
	git add . || die
	git commit -m 'init' || die

	#pure madness
	#https://github.com/source-foundry/font-v/blob/e6746e4a045c99e56af661918c96259b1f444ed4/tests/test_utilities.py#L34
	sed -e "s|\"font-v\"|\"${PWD##*/}\"|g" -i "tests/test_utilities.py" || die

	python_foreach_impl python_test
}
