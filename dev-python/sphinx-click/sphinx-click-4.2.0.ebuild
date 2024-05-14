# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx plugin to automatically document click-based applications"
HOMEPAGE="
	https://github.com/click-contrib/sphinx-click
	https://pypi.org/project/sphinx-click/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/sphinx-2.0[${PYTHON_USEDEP}]
	>=dev-python/click-7.0[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/pbr-2.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc
