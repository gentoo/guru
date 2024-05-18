# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3  )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Pure-python reader for DAWGs (DAFSAs) created by dawgdic C++ library."
HOMEPAGE="
	https://github.com/pytries/DAWG-Python
	https://pypi.org/project/DAWG-Python/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
