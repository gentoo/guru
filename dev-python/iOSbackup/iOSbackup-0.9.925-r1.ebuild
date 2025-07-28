# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="Reads and extracts files from a password-encrypted iOS backup"
HOMEPAGE="
	https://pypi.org/project/iOSbackup/
	https://github.com/avibrazil/iOSbackup
"

# The project only states LGPL in setup.py
LICENSE="
	|| (
		LGPL-2
		LGPL-2+
		LGPL-2-with-linking-exception
		LGPL-2.1
		LGPL-2.1+
		LGPL-2.1-with-linking-exception
		LGPL-3
		LGPL-3+
		LGPL-3-with-linking-exception
	)
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/NSKeyedUnArchiver[${PYTHON_USEDEP}]
"
