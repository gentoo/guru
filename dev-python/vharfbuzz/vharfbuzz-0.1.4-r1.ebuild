# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A user-friendlier way to use Harfbuzz in Python"
HOMEPAGE="
	https://pypi.org/project/vharfbuzz/
	https://github.com/simoncozens/vharfbuzz
"
SRC_URI="https://github.com/simoncozens/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/uharfbuzz[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs
