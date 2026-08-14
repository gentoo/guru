# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MY_PN="QSchematic"

inherit cmake

DESCRIPTION="Library for creating flowcharts and engineering diagrams"
HOMEPAGE="https://github.com/simulton/QSchematic"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/simulton/QSchematic/${MY_PN}.git"
else
	SRC_URI="https://github.com/simulton/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~riscv ~x86"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="examples static-libs test wayland +X"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	examples? ( static-libs )
	test? ( static-libs )
"
RDEPEND="
	>=dev-qt/qtbase-6.5:6=[gui,wayland?,widgets,X?]
	>=dev-qt/qtimageformats-6.5:6
	>=dev-qt/qtsvg-6.5:6
	>=dev-libs/gpds-1.8.4[static-libs?]
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DQSCHEMATIC_DEPENDENCY_GPDS_TARGET:STRING="gpds::gpds-shared"
		-DQSCHEMATIC_DEPENDENCY_GPDS_DOWNLOAD=OFF
		-DQSCHEMATIC_BUILD_DEMO=$(usex examples)
		-DQSCHEMATIC_BUILD_STATIC=$(usex static-libs)
		-DQSCHEMATIC_BUILD_SHARED=ON
	)

	cmake_src_configure
}
