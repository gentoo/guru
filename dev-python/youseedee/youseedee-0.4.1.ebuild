# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Interface to the Unicode Character Database"
HOMEPAGE="
	https://pypi.org/project/youseedee/
	https://github.com/simoncozens/youseedee
"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
