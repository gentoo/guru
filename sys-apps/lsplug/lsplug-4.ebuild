# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_REQ_USE=sqlite
PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Replacement for lsusb that shows more useful info and less useless info"
HOMEPAGE="https://git.sr.ht/~martijnbraam/lsplug"
SRC_URI="https://git.sr.ht/~martijnbraam/lsplug/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# For /usr/share/hwdata/usb.ids
RDEPEND="sys-apps/hwdata"
