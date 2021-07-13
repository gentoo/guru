# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="A user-friendlier way to use Harfbuzz in Python"
HOMEPAGE="https://github.com/simoncozens/vharfbuzz"
SRC_URI="https://github.com/simoncozens/vharfbuzz/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/uharfbuzz[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-fix-package-dir.patch" )

distutils_enable_sphinx docs dev-python/sphinxcontrib-napoleon
