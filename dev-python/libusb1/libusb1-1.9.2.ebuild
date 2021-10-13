# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Pure-python wrapper for libusb-1.0"
HOMEPAGE="https://github.com/vpelletier/python-libusb1"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/libusb"
DEPEND="dev-python/wheel[${PYTHON_USEDEP}]"

distutils_enable_tests setup.py
