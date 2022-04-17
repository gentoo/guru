# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 optfeature

DESCRIPTION="A 21 century R console"
HOMEPAGE="
	https://pypi.org/project/radian/
	https://github.com/randy3k/radian
"
SRC_URI="https://github.com/randy3k/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}-github.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/rchitect-0.3.36[${PYTHON_USEDEP}]
	>=dev-python/prompt_toolkit-3.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.5.0[${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
	dev-lang/R
"
BDEPEND="
	test? (
		>=dev-python/pyte-0.8.0[${PYTHON_USEDEP}]
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/ptyprocess[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-no-pytest-runner.patch" )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "prompt completions" dev-python/jedi
}
