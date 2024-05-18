# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Header-only library for parsing TOML"
HOMEPAGE="https://github.com/skystrife/cpptoml"
SRC_URI="https://github.com/skystrife/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libcxx examples"

RDEPEND="libcxx? ( sys-libs/libcxx )"
DEPEND="${RDEPEND}"

PATCHES="${FILESDIR}/${P}-limits.patch"

src_configure() {
	local mycmakeargs=(
	        -DCPPTOML_BUILD_EXAMPLES=$(usex examples)
		-DENABLE_LIBCXX=$(usex libcxx)
	)
	cmake_src_configure
}
