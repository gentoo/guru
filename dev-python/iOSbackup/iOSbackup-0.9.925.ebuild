# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Reads and extracts files from a password-encrypted iOS backup"
HOMEPAGE="https://pypi.org/project/iOSbackup/ https://github.com/avibrazil/iOSbackup"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="dev-python/biplist[${PYTHON_USEDEP}]
dev-python/pycryptodome[${PYTHON_USEDEP}]
dev-python/NSKeyedUnArchiver[${PYTHON_USEDEP}]"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
