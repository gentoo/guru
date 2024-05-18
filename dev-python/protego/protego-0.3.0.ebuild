# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Pure-Python robots.txt parser with support for modern conventions"
HOMEPAGE="
	https://scrapy.org/
	https://pypi.org/project/protego/
	https://github.com/scrapy/protego
"
SRC_URI="https://github.com/scrapy/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
