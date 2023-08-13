# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Unserializes binary|text|file|memory plist data to Python dict"
HOMEPAGE="https://github.com/avibrazil/NSKeyedUnArchiver"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
