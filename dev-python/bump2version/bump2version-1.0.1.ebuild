# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Version-bump your software with a single command!"
HOMEPAGE="
	https://pypi.org/project/bump2version/
	https://github.com/c4urself/bump2version
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-vcs/git
		dev-vcs/mercurial
		dev-python/testfixtures[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	tests/test_cli.py::test_usage_string
	"tests/test_cli.py::test_regression_help_in_work_dir[git]"
	"tests/test_cli.py::test_regression_help_in_work_dir[hg]"
	tests/test_cli.py::test_defaults_in_usage_with_config
)

distutils_enable_tests pytest

src_test() {
	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die

	distutils-r1_src_test
}
