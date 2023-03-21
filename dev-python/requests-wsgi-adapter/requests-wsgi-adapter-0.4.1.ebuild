# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="WSGI Transport Adapter for Requests"
HOMEPAGE="
	https://github.com/seanbrant/requests-wsgi-adapter/
	https://pypi.org/project/requests-wsgi-adapter/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
