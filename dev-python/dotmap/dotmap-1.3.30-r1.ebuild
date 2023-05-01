# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Dot access dictionary with dynamic hierarchy creation and ordered iteration"
HOMEPAGE="
	https://pypi.org/project/dotmap/
	https://github.com/drgrib/dotmap
"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

distutils_enable_tests unittest
