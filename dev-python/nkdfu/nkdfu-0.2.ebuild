# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# officially supports only py3.11 but works on newer too
DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Python DFU tool for updating Nitrokey firmware"
HOMEPAGE="https://github.com/Nitrokey/nkdfu"
SRC_URI="https://github.com/Nitrokey/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/intelhex-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/libusb1-1.9.3[${PYTHON_USEDEP}]
	dev-python/python-fire[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
