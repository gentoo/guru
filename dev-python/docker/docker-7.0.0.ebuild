# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1 pypi

MY_P=docker-py-${PV}
DESCRIPTION="A Python library for the Docker Engine API."
HOMEPAGE="
	https://github.com/docker/docker-py
	https://pypi.org/project/docker/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="websockets"

RDEPEND="
	>=dev-python/requests-2.26.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26.0[${PYTHON_USEDEP}]
	websockets? ( >=dev-python/websocket-client-1.3.0[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
