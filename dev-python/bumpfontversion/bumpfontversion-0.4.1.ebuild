# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="Bumps the version of a font source file"
HOMEPAGE="
	https://pypi.org/project/bumpfontversion/
	https://github.com/simoncozens/bumpfontversion
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/glyphsLib[${PYTHON_USEDEP}]
	dev-python/openstep-plist[${PYTHON_USEDEP}]
	dev-python/ufoLib2[${PYTHON_USEDEP}]
	dev-util/bump2version[${PYTHON_USEDEP}]
"
