# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )
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
PATCHES=(
	"${FILESDIR}"/${P}-deprecated-chevron-to-jinja.patch
)

DOCS="README* CHANGELOG*"

RDEPEND="
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
