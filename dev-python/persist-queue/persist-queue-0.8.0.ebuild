# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="A thread-safe disk based persistent queue in Python"
HOMEPAGE="https://github.com/peter-wangxu/persist-queue"
LICENSE="BSD"


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
