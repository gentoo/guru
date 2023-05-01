# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Take The Time, a super-neat Python library for timing chunks of code"
HOMEPAGE="https://github.com/ErikBjare/TakeTheTime"
LICENSE="MIT"


KEYWORDS="~amd64"
SLOT="0"

# Not available for now
RESTRICT="test"
