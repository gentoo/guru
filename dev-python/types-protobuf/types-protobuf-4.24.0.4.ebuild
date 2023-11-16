# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Typing stubs for protobuf"
HOMEPAGE="
	https://pypi.org/project/types-protobuf/
	https://github.com/python/typeshed/tree/master/stubs/protobuf/
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
