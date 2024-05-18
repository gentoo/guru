# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Collection of persistent and non-persistent queues for Python"
HOMEPAGE="https://scrapy.org/"
SRC_URI="https://github.com/scrapy/queuelib/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

distutils_enable_tests pytest
