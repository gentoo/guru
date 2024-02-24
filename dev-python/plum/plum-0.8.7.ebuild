# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{7..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Pack/Unpack Memory"

HOMEPAGE="https://gitlab.com/dangass/plum"
SRC_URI="https://gitlab.com/dangass/${PN}/-/archive/${PV}/${PN}-${PV}.tar.bz2"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"
