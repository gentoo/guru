# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Data derived from the OpenType specification"
HOMEPAGE="
	https://pypi.org/project/opentypespec/
	https://github.com/simoncozens/opentypespec-py
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

distutils_enable_tests pytest
