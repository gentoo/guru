# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Robust mesh cutting and Boolean operations library"
HOMEPAGE="https://github.com/cutdigital/mcut"
SRC_URI="https://github.com/cutdigital/mcut/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+ MPL-2.0 public-domain"
SLOT="0/1.3.0"
KEYWORDS="~amd64"
# Tests fetch dependencies during configuration.
RESTRICT="test"

PATCHES=( "${FILESDIR}/${P}-build.patch" )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_STANDARD=17
		-DMCUT_BUILD_AS_SHARED_LIB=ON
		-DMCUT_BUILD_DOCUMENTATION=OFF
		-DMCUT_BUILD_TESTS=OFF
		-DMCUT_BUILD_TUTORIALS=OFF
	)
	cmake_src_configure
}
