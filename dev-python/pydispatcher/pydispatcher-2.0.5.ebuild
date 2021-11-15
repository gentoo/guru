# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism"
HOMEPAGE="https://github.com/scrapy/pypydispatcher https://pypi.org/project/PyPyDispatcher/"
MY_P=PyDispatcher
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_P}/${MY_P}-${PV}.tar.gz"
S=${WORKDIR}/${MY_P}-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
