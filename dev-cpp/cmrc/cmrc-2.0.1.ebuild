# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A Resource Compiler in a Single CMake Script"
HOMEPAGE="https://github.com/vector-of-bool/cmrc"
SRC_URI="https://raw.githubusercontent.com/vector-of-bool/cmrc/${PV}/CMakeRC.cmake -> ${P}.cmake"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_install() {
	local cmakedir="/usr/share/cmake/CMakeRC"

	insinto "${cmakedir}"
	newins "${DISTDIR}/${P}.cmake" CMakeRC.cmake
	newins - CMakeRCConfig.cmake <<-EOF
		include("\${CMAKE_CURRENT_LIST_DIR}/CMakeRC.cmake")
	EOF
}
