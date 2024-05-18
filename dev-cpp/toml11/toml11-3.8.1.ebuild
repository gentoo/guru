# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

SPEC_V=0.5.0

DESCRIPTION="TOML for Modern C++"
HOMEPAGE="https://github.com/ToruNiina/toml11"
SRC_URI="
	https://github.com/ToruNiina/toml11/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/toml-lang/toml/archive/refs/tags/v0.5.0.tar.gz -> toml-${SPEC_V}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-libs/boost )"

PATCHES=( "${FILESDIR}/${P}-werror.patch" )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_STANDARD=11
		-DTOML11_LANGSPEC_SOURCE_DIR="${WORKDIR}/toml-${SPEC_V}"
		-Dtoml11_BUILD_TEST=$(usex test)
	)
	cmake_src_configure
}
