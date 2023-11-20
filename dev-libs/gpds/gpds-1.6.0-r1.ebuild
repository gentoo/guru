# Copyright 1999-2023 Gentoo Authors
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
IUSE="examples +spdlog static-libs test"
RESTRICT="!test? ( test )"
DEPEND="${RDEPEND}"

DOCS=( license.txt readme.md )

src_prepare() {
	cmake_src_prepare
	use static-libs || sed -i -e '/TARGET-STATIC/d' "${S}"/lib/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DGPDS_BUILD_EXAMPLES=$(usex examples)
		-DGPDS_BUILD_TESTS=$(usex test)
		-DGPDS_FEATURE_SPDLOG=$(usex spdlog)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	# use static-libs || rm "${ED}"/usr/$(get_libdir)/*.a || die
}
