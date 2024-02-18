# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A general purpose data serializer"
HOMEPAGE="https://gpds.simulton.com"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/simulton/${PN}.git"
else
	SRC_URI="https://github.com/simulton/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc ~x86"
	S="${WORKDIR}/${PN}-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="examples static-libs test"
RESTRICT="!test? ( test )"
DEPEND="${RDEPEND}"

DOCS=( license.txt readme.md )

src_configure() {
	local mycmakeargs=(
		-DGPDS_BUILD_STATIC=$(usex static-libs)
		-DGPDS_BUILD_SHARED=ON
		-DGPDS_BUILD_TESTS=$(usex test)
		-DGPDS_BUILD_EXAMPLES=$(usex examples)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
