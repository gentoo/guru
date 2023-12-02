# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Python command line client for tldr pages"
HOMEPAGE="https://github.com/tldr-pages/tldr-python-client"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	${PYTHON_DEPS}
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
	!app-misc/tealdeer
"
