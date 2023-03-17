# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A library and CLI tool for making gemini requests"
HOMEPAGE="https://notabug.org/tinyrabbit/gemcall/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]"
