# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Reads and extracts files from a password-encrypted iOS backup"
HOMEPAGE="https://pypi.org/project/iOSbackup/ https://github.com/avibrazil/iOSbackup"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-python/biplist[${PYTHON_USEDEP}]
dev-python/pycryptodome[${PYTHON_USEDEP}]
dev-python/NSKeyedUnArchiver[${PYTHON_USEDEP}]"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
