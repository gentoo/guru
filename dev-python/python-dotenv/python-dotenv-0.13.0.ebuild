# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

# Some failures, likely an incompatibility with newer versions of sh (no old in ::gentoo)
RESTRICT="test"

DESCRIPTION="Get and set values in your .env file in local and production servers"
HOMEPAGE="https://github.com/theskumar/python-dotenv"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

distutils_enable_tests pytest

DEPEND="test? (
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
)"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"
