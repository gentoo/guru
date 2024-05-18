# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Create Windows installer USB from ISO (rewrite of WoeUSB)"
HOMEPAGE="https://github.com/WoeUSB/WoeUSB-ng"
SRC_URI="https://github.com/WoeUSB/WoeUSB-ng/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/WoeUSB-ng-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/wxpython
"
RDEPEND="
	app-arch/p7zip
	sys-boot/grub[grub_platforms_pc]
"
