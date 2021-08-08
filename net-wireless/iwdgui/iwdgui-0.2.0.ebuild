# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 xdg

DESCRIPTION="A graphical frontend for IWD, Intel's iNet Wireless Daemon"
HOMEPAGE="https://gitlab.com/hfernh/iwdgui https://pypi.org/project/iwdgui"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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
