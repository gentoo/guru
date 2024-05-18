# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of Protocol Buffers data types with dataclasses support"
HOMEPAGE="
	https://github.com/eigenein/protobuf
	https://pypi.org/project/pure-protobuf/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${P}-static-version.patch" )
