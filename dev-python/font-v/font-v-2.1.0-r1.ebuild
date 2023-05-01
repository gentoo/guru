# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 edo

DESCRIPTION="Font version reporting and modification tool"
HOMEPAGE="https://github.com/source-foundry/font-v"
SRC_URI="https://github.com/source-foundry/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-vcs/git )"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

src_unpack() {
	default

	# tests expect default git clone
	mv "${WORKDIR}"/{${P},${PN}} || die
}

src_test() {
	edo git init
	edo git config --global user.email "larry@example.com"
	edo git config --global user.name "Larry the Cow"
	edo git add .
	edo git commit -m "init"

	distutils-r1_src_test
}
