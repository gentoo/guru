# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="A collection of classes implementing the pen protocol for manipulating glyphs"
HOMEPAGE="
	https://pypi.org/project/fontPens/
	https://github.com/robotools/fontPens
"
SRC_URI=$(pypi_sdist_url --no-normalize ${PN} ${PV} .zip)

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/fonttools-3.32[${PYTHON_USEDEP}]"
BDEPEND="
	app-arch/unzip
	test? (
		>=dev-python/fontParts-0.8.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
