# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Version bump your Python project"
HOMEPAGE="
	https://pypi.org/project/bump-my-version/
	https://callowayproject.github.io/bump-my-version/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0[${PYTHON_USEDEP}]
	dev-python/pydantic-settings[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/rich-click[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	>=dev-python/wcmatch-8.5.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-vcs/git
		dev-vcs/mercurial
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

DOCS=( {CHANGELOG,CODE_OF_CONDUCT,CONTRIBUTING,README}.md )

distutils_enable_tests pytest

python_test() {
	epytest -o "addopts="
}

src_test() {
	local -x TZ="UTC"

	git config --global user.email "you@example.com" || die
	git config --global user.name "Your Name" || die

	distutils-r1_src_test
}
