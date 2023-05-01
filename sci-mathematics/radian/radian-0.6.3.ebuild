# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_10 )

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
	$(python_gen_cond_dep	'
		>=dev-python/prompt-toolkit-3.0.15[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/rchitect-0.3.36[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	dev-lang/R
"
BDEPEND="
	test? (
		$(python_gen_cond_dep	'
			>=dev-python/pyte-0.8.0[${PYTHON_USEDEP}]
			dev-python/pexpect[${PYTHON_USEDEP}]
			dev-python/ptyprocess[${PYTHON_USEDEP}]
			dev-python/jedi[${PYTHON_USEDEP}]
		')
		dev-R/askpass
		dev-R/reticulate[${PYTHON_SINGLE_USEDEP}]
		dev-vcs/git
	)
"

PATCHES=( "${FILESDIR}/${PN}-0.6.0-no-pytest-runner.patch" )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "prompt completions" dev-python/jedi
}
