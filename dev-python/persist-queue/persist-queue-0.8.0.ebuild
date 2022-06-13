# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10})

inherit distutils-r1

DESCRIPTION="A thread-safe disk based persistent queue in Python"
HOMEPAGE="https://github.com/peter-wangxu/persist-queue"
LICENSE="BSD"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"

# It tries to connecto to a local MySQL server
RESTRICT="test"

DEPEND="
	dev-python/dbutils[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

#distutils_enable_tests nose
