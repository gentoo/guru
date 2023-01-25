# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="python-dbus-next is a Python library for DBus"
HOMEPAGE="
	https://github.com/altdesktop/python-dbus-next
	https://pypi.org/project/dbus-next/
"
SRC_URI="https://github.com/altdesktop/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

# some tests fail with:
# dbus_next.errors.InvalidAddressError:
# DBUS_SESSION_BUS_ADDRESS not set and could not get DISPLAY environment variable to get bus addres
# or require certain services to be installed (like org.freedesktop.DBus.Debug.Stats)
RESTRICT="test"
