# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Collection of persistent and non-persistent queues for Python"
HOMEPAGE="https://scrapy.org/"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~arm64 ~x86"

# Tests requires network(tox), can't work inside network sandbox
RESTRICT="test"
