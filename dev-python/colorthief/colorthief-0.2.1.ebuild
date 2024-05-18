# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Module for grabbing the color palette from an image"
HOMEPAGE="
	https://github.com/fengsp/color-thief-py
	https://pypi.org/project/colorthief/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]"
