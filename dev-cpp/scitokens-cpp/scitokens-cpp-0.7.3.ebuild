# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/scitokens/scitokens-cpp"
else
	SRC_URI="https://github.com/scitokens/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION=" A C++ implementation of the SciTokens library with a C library interface"
HOMEPAGE="https://scitokens.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

DEPEND="${RDEPEND}
	<dev-cpp/jwt-cpp-0.5.0
	dev-db/sqlite
	dev-libs/openssl
	net-misc/curl
	sys-apps/util-linux
	test? ( dev-cpp/gtest )"
BDEPEND="virtual/pkgconfig"
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/"${PN}"-0.7.1-fix-external-gtest.patch
)

src_prepare() {
	# Unbundle dev-cpp/gtest, dev-cpp/jwt-cpp
	rm -r vendor || die
	# Fix include path for picojson.
	find src/ \( -name '*.cpp' -o -name '*.h' \) -type f -print0 | xargs -0 sed -r -e "s:picojson/picojson\.h:picojson.h:g" -i || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
			-DSCITOKENS_BUILD_UNITTESTS="$(usex test)"
			-DSCITOKENS_EXTERNAL_GTEST=YES
			)
	cmake_src_configure
}

src_test() {
	cmake_run_in "${BUILD_DIR}" ctest --verbose || die
}
