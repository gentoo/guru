# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Removes unused imports and unused variables from Python code"
HOMEPAGE="https://github.com/PyCQA/autoflake/ https://pypi.org/project/autoflake/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/tomli-2.0.1
		 >=dev-python/pyflakes-3.0.0"

#pypi tarbal does not include tests
RESTRICT="test"

src_prepare() {
		eapply_user
		sed -Ei -e '/include/,/]/ { /(test_.*|LICENSE|README)/d }' pyproject.toml || die "Sed failed :-("
}
