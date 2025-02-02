# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Simple, extensible Markov chain generator"
HOMEPAGE="
	https://pypi.org/project/markovify/
	https://github.com/jsvine/markovify
"
SRC_URI="https://github.com/jsvine/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/unidecode[${PYTHON_USEDEP}]"

# Does not work with vanilla unittest,
# test suite is designed for running with nose.
distutils_enable_tests pytest
