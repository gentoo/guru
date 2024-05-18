# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python package providing assets from https://github.com/Kozea/pygal.js"
HOMEPAGE="
	https://github.com/ionelmc/python-pygaljs
	https://pypi.org/project/pygaljs/
"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

distutils_enable_tests pytest
