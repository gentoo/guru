# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9,10} )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="Python implementation of the systemd sd_notify protocol"
HOMEPAGE="https://github.com/bb4242/sdnotify"
SRC_URI="https://github.com/bb4242/${PN}/archive/refs/tags/v${PV}.tar.gz -> bb4242-${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
