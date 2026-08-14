# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="A wrapper for all Deezer's APIs"
HOMEPAGE="https://pypi.org/project/deezer-py/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

distutils_enable_tests import-check

src_install() {
	distutils-r1_src_install

	dodoc LICENSE.txt
}
