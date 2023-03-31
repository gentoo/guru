# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake

DESCRIPTION="A fast and densely stored hashmap and hashset"
HOMEPAGE="https://github.com/martinus/unordered_dense"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/martinus/${PN}.git"
else
	SRC_URI="https://github.com/martinus/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
	S="${WORKDIR}/${P}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""

DEPEND="
	${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-D CMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-D BUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
}
