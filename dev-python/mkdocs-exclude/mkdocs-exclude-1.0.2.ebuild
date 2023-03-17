# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 pypi

DESCRIPTION="Lets you exclude files or trees from your output"
HOMEPAGE="https://github.com/apenwarr/mkdocs-exclude"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="dev-python/mkdocs[${PYTHON_USEDEP}]"
