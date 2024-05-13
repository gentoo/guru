# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A Python library for easily pattern matching wildcard URLs"
HOMEPAGE="https://github.com/jessepollak/urlmatch"
SRC_URI="https://github.com/jessepollak/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

src_prepare(){
	sed 's/find_packages()/find_packages(exclude=["tests*"])/' -i setup.py || die
	default
}

python_test(){
	eunittest tests/ "*.py"
}
