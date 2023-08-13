# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Pure-python wrapper for libusb-1.0"
HOMEPAGE="https://github.com/vpelletier/python-libusb1 https://pypi.org/project/libusb1/"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/libusb"

distutils_enable_tests setup.py
