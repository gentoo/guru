# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Generate random strings matching a pattern"
HOMEPAGE="
	https://pypi.org/project/stringbrewer/
	https://github.com/simoncozens/stringbrewer
"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/rstr[${PYTHON_USEDEP}]
	dev-python/sre-yield[${PYTHON_USEDEP}]
"
