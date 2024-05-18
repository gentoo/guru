# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

PATCHES=(
	"${FILESDIR}/build-fix.patch"
)
DESCRIPTION="Blockchain Commons UR Library"
HOMEPAGE="https://github.com/BlockchainCommons/bc-ur/tree/"
SRC_URI="https://github.com/BlockchainCommons/bc-ur/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	cmake_build bcur_static
}
