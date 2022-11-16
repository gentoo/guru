# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_TRANTOR_V="1.5.8"

DESCRIPTION="C++14/17 based HTTP web application framework"
HOMEPAGE="https://github.com/drogonframework/drogon"
SRC_URI="
	https://github.com/drogonframework/drogon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/an-tao/trantor/archive/refs/tags/v${MY_TRANTOR_V}.tar.gz -> trantor-${MY_TRANTOR_V}.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+brotli doc examples mariadb postgres redis sqlite +ssl test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-cpp/trantor-${MY_TRANTOR_V}:=
	dev-libs/jsoncpp:=
	sys-libs/zlib
	brotli? ( app-arch/brotli:= )
	mariadb? ( dev-db/mariadb:= )
	postgres? ( dev-db/postgresql:= )
	redis? ( dev-libs/hiredis:= )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl:= )
	elibc_Darwin? ( sys-libs/native-uuid )
	elibc_SunOS? ( sys-libs/libuuid )
	!elibc_Darwin? ( !elibc_SunOS? (
		sys-apps/util-linux
	) )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"
BDEPEND="doc? ( app-doc/doxygen )"

DOCS=( CONTRIBUTING.md ChangeLog.md README.md README.zh-CN.md README.zh-TW.md )

src_unpack() {
	default

	# the cert is in the trantor submodule normally, but we unbundle that
	if use test; then
		mkdir -p ${P}/trantor/trantor/tests || die
		cp -v trantor-${MY_TRANTOR_V}/trantor/tests/server.pem \
			${P}/trantor/trantor/tests/server.pem \
			|| die "could not copy test certificate"
	fi
}

src_prepare() {
	use examples && DOCS+=( "${S}/examples" )

	cmake_comment_add_subdirectory "trantor"

	cmake_src_prepare
}

src_configure() {
	use doc && HTML_DOCS=( "${BUILD_DIR}/docs/drogon/html/." )

	local -a mycmakeargs=(
		-DBUILD_DOC=$(usex doc)
		-DBUILD_EXAMPLES=NO
		-DBUILD_POSTGRESQL=$(usex postgres)
		-DBUILD_MYSQL=$(usex mariadb)
		-DBUILD_SQLITE=$(usex sqlite)
		-DBUILD_REDIS=$(usex redis)
		-DBUILD_TESTING=$(usex test)
		-DBUILD_BROTLI=$(usex brotli)
		$(cmake_use_find_package ssl OpenSSL)
		$(cmake_use_find_package doc Doxygen)
	)

	cmake_src_configure
}

src_install() {
	docompress -x /usr/share/doc/${PF}/examples

	cmake_src_install
}
