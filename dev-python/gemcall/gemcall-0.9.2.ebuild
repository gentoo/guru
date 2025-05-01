# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A library and CLI tool for making gemini requests"
HOMEPAGE="https://notabug.org/tinyrabbit/gemcall/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]"

distutils_enable_tests import-check
