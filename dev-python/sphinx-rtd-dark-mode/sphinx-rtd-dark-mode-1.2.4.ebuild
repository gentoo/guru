# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="sphinx_rtd_dark_mode"
DESCRIPTION="Dark mode for the Sphinx Read the Docs theme"
HOMEPAGE="
	https://pypi.org/project/sphinx-rtd-dark-mode/
	https://github.com/MrDogeBro/sphinx_rtd_dark_mode
"
SRC_URI="https://github.com/MrDogeBro/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
"

DOCS=( {CONTRIBUTING,README}.md )

distutils_enable_tests pytest

python_test() {
	epytest tests/build.py
}
