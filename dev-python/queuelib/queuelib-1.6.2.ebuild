# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="Collection of persistent and non-persistent queues for Python"
HOMEPAGE="https://scrapy.org/"
SRC_URI="https://github.com/scrapy/queuelib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
