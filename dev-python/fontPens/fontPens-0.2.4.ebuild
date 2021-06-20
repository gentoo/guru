# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/robotools/fontPens/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="A collection of classes implementing the pen protocol for manipulating glyphs"
HOMEPAGE="https://github.com/robotools/fontPens"
LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/fonttools-3.32[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/fontParts[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
