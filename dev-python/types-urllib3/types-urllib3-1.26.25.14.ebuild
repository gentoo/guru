# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Typing stubs for urllib3"
HOMEPAGE="
	https://pypi.org/project/types-urllib3/
	https://github.com/python/typeshed/tree/master/stubs/urllib3
"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
