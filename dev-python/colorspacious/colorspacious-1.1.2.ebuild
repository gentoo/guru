# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for doing colorspace conversions"
HOMEPAGE="
	https://pypi.org/project/colorspacious/
	https://github.com/njsmith/colorspacious
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
"
