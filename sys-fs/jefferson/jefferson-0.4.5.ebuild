# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

DESCRIPTION=" JFFS2 filesystem extraction tool "
HOMEPAGE="https://github.com/onekey-sec/jefferson"
SRC_URI="https://github.com/onekey-sec/${PN}/archive/refs/tags/v${PV}.tar.gz	-> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cstruct[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/python-lzo[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-use-python-lzo.patch" )
