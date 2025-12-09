# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Python cross-version bytecode library and disassembler"
HOMEPAGE="
	https://github.com/rocky/python-xdis
"
SRC_URI="
	https://github.com/rocky/python-xdis/releases/download/${PV}/xdis-${PV}.tar.gz
		-> ${PV}.gh.tar.gz
"
S="${WORKDIR}/xdis-${PV}"
RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests import-check

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
