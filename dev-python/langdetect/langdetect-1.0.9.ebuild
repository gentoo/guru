# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Port of Google's language-detection library to Python"
HOMEPAGE="
	https://pypi.org/project/langdetect/
	https://github.com/Mimino666/langdetect
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${P}-explicit-config.patch" )

distutils_enable_tests unittest
