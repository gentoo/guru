# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++14/17 based HTTP web application framework"
HOMEPAGE="https://github.com/drogonframework/drogon"
SRC_URI="https://github.com/drogonframework/drogon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+brotli doc examples mariadb postgres redis sqlite +ssl test"
RESTRICT="!test? ( test )"

# NOTE: The trantor[adns] dependency should not be needed,
# see <https://github.com/drogonframework/drogon/issues/1058>
RDEPEND="
	>=dev-cpp/trantor-1.5.2[adns]
	dev-libs/jsoncpp
	sys-libs/zlib
	brotli? ( app-arch/brotli )
	mariadb? ( dev-db/mariadb:= )
	postgres? ( dev-db/postgresql:= )
	redis? ( dev-libs/hiredis )
	sqlite? ( dev-db/sqlite )
	ssl? ( dev-libs/openssl )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"
BDEPEND="doc? ( app-doc/doxygen )"

DOCS=( CONTRIBUTING.md ChangeLog.md README.md README.zh-CN.md README.zh-TW.md )

src_prepare() {
	cmake_comment_add_subdirectory "trantor"
	sed -i '/${PROJECT_SOURCE_DIR}\/trantor\/trantor\/tests\/server.pem/d' \
		lib/tests/CMakeLists.txt || die
	use ssl || sed -i '/find_package(OpenSSL)/d' CMakeLists.txt || die
	use doc || sed -i '/find_package(Doxygen/d' CMakeLists.txt || die

	use examples && DOCS+=( "${S}/examples" )

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		"-DBUILD_DOC=$(usex doc)"
		"-DBUILD_EXAMPLES=NO"
		"-DBUILD_DROGON_SHARED=YES"
		"-DBUILD_POSTGRESQL=$(usex postgres)"
		"-DBUILD_MYSQL=$(usex mariadb)"
		"-DBUILD_SQLITE=$(usex sqlite)"
		"-DBUILD_REDIS=$(usex redis)"
		"-DBUILD_TESTING=$(usex test)"
		"-DBUILD_BROTLI=$(usex brotli)"
	)
	use doc && HTML_DOCS="${BUILD_DIR}/docs/drogon/html/*"

	cmake_src_configure
}
