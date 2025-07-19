# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="An easy-to-use cross-platform library for USB device monitoring"
HOMEPAGE="https://github.com/Eric-Canas/USBMonitor https://pypi.org/project/usb-monitor/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pyudev[${PYTHON_USEDEP}]"
