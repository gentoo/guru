# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=standalone
PYTHON_REQ_USE="ssl(+),threads(+)"

inherit distutils-r1 pypi

DESCRIPTION="Coroutine-based network library"
HOMEPAGE="https://www.gevent.org/ https://pypi.org/project/gevent/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="monitor recommended"

RDEPEND="
	>=dev-python/greenlet-3.0[${PYTHON_USEDEP}]
	dev-python/zope-event[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	monitor? ( >=dev-python/psutil-5.7.0[${PYTHON_USEDEP}] )
	recommended? (
		>=dev-python/cffi-1.12.2[${PYTHON_USEDEP}]
		>=dev-python/psutil-5.7.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="${RDEPEND}"
