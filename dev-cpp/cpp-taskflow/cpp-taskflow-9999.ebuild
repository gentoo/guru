# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Modern C++ Parallel Task Programming"
HOMEPAGE="https://cpp-taskflow.github.io"
if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/cpp-taskflow/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/cpp-taskflow/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/${P}-optional-tests-examples.patch
	"${FILESDIR}"/${P}-fix-lib-path.patch
)

src_configure() {
	local mycmakeargs=(
		-DTF_BUILD_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}
