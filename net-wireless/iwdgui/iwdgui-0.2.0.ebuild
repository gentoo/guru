# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 xdg pypi

DESCRIPTION="A graphical frontend for IWD, Intel's iNet Wireless Daemon"
HOMEPAGE="https://gitlab.com/hfernh/iwdgui https://pypi.org/project/iwdgui/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""
REQUIRED_USE=""

# Upstream does not provide any test suite.
RESTRICT="test"

RDEPEND="
	dev-python/dbus-python
	dev-python/netifaces
	dev-python/pygobject
	net-wireless/iwd"

BDEPEND="${RDEPEND}"
DEPEND="${BDEPEND}"
