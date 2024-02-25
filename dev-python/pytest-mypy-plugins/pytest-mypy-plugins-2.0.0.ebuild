# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )
inherit distutils-r1

DESCRIPTION="pytest plugin for testing mypy types, stubs, plugins"
HOMEPAGE="
	https://pypi.org/project/pytest-mypy-plugins/
	https://github.com/typeddjango/pytest-mypy-plugins/
"

SRC_URI="https://github.com/typeddjango/pytest-mypy-plugins/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS="README* CHANGELOG*"

RDEPEND="
	>=dev-python/mypy-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	# --mypy-only-local-stub is a workaround for bug #921901
	epytest --mypy-only-local-stub
}
