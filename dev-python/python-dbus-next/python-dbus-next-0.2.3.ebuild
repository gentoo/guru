# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="python-dbus-next is a Python library for DBus"
HOMEPAGE="
	https://github.com/altdesktop/python-dbus-next
	https://pypi.org/project/dbus-next
"
SRC_URI="https://github.com/altdesktop/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest

# some tests fail with:
# dbus_next.errors.InvalidAddressError: DBUS_SESSION_BUS_ADDRESS not set and could not get DISPLAY environment variable to get bus addres
RESTRICT="test"
