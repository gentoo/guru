# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism"
HOMEPAGE="https://github.com/mcfletch/pydispatcher"
MY_P=PyDispatcher
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_P}/${MY_P}-${PV}.tar.gz"
S=${WORKDIR}/${MY_P}-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
