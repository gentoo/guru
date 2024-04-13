# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Manipulate ASCII art as you would do with raster images"
HOMEPAGE="https://github.com/fakefred/ascim"
SRC_URI="https://github.com/fakefred/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
