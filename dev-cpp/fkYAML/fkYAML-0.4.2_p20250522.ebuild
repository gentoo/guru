# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

EGIT_COMMIT="721edb3e1a817e527fd9e1e18a3bea300822522e"

DESCRIPTION="A C++ header-only YAML library"
HOMEPAGE="https://fktn-k.github.io/fkYAML/"
SRC_URI="https://github.com/fktn-k/fkYAML/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? ( =dev-cpp/catch-2* )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.4.2_p20250522-Use-system-Catch2.patch"
)

src_prepare() {
	find thirdparty -mindepth 1 -not -name imapdl -delete || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DFK_YAML_BUILD_TEST=$(usex test)
	)

	cmake_src_configure
}
