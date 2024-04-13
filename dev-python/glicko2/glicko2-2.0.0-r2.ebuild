# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="glicko2 implementation in python"
HOMEPAGE="https://github.com/deepy/glicko2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

src_prepare() {
	sed -e "s/find_packages()/find_packages(exclude=['tests'])/" \
		-i setup.py || die
	distutils-r1_src_prepare
}
