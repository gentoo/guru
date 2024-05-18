# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Lets you exclude files or trees from your output"
HOMEPAGE="
	https://pypi.org/project/mkdocs-exclude/
	https://github.com/apenwarr/mkdocs-exclude
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/mkdocs[${PYTHON_USEDEP}]"
