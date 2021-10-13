# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{8,9} pypy3)

inherit distutils-r1

DESCRIPTION="glicko2 implementation in python"
HOMEPAGE="https://github.com/deepy/glicko2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests setup.py

src_prepare() {
	sed -i -e "s/distribute/setuptools/g" \
		-e 's/setuptools.find_packages()/setuptools.find_packages(exclude=["*test*"])/g' \
		setup.py
	default
}
