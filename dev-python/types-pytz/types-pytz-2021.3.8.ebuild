# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Typing stubs for pytz"
HOMEPAGE="
	https://pypi.org/project/types-pytz/
	https://github.com/python/typeshed/tree/master/stubs/pytz
"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
