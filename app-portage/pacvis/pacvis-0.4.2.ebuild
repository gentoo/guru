# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
inherit distutils-r1

DESCRIPTION="Displays dependency graphs of packages"
HOMEPAGE="https://github.com/bgloyer/pacvis"
SRC_URI="https://github.com/bgloyer/pacvis/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/tornado[${PYTHON_USEDEP}]"
