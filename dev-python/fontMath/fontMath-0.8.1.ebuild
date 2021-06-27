# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/robotools/fontMath/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="A collection of objects that implement fast font math"
HOMEPAGE="https://github.com/robotools/fontMath"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/fonttools-4.9[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
