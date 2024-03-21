# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
inherit check-reqs cmake docs edo git-r3 java-pkg-opt-2

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="
	https://core.telegram.org/tdlib
	https://github.com/tdlib/td
"
EGIT_REPO_URI="https://github.com/tdlib/${PN}.git"

LICENSE="Boost-1.0"
SLOT="0"
IUSE="abseil dotnet +jumbo-build static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl:=
	sys-libs/zlib:=
	abseil? ( dev-cpp/abseil-cpp:= )
	dotnet? ( virtual/dotnet-sdk:* )
	java? ( >=virtual/jdk-11:*[-headless-awt] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/php[cli]
	dev-util/gperf
"

DOCS=( CHANGELOG.md README.md )

CHECKREQS_MEMORY="2G"

pkg_pretend() {
	use test && check-reqs_pkg_pretend
}

pkg_setup() {
	java-pkg-opt-2_pkg_setup

	use test && check-reqs_pkg_setup
}

src_prepare() {
	sed "/find_program(CCACHE_FOUND ccache)/d" -i CMakeLists.txt || die

	cmake_comment_add_subdirectory benchmark
	use test || \
		cmake_comment_add_subdirectory test

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTD_ENABLE_DOTNET=$(usex dotnet)
		-DTD_ENABLE_JNI=$(usex java)
		-DTD_WITH_ABSEIL=$(usex abseil)
		-DTD_TEST_FOLLY=OFF
	)

	if use java; then
		mycmakeargs+=(
			-DJAVA_AWT_LIBRARY="${JAVA_HOME}/lib/libjawt.so"
			-DJAVA_JVM_LIBRARY="${JAVA_HOME}/lib/libjava.so"
			-DJAVA_INCLUDE_PATH="${JAVA_HOME}/include"
			-DJAVA_INCLUDE_PATH2="${JAVA_HOME}/include/linux"
			-DJAVA_AWT_INCLUDE_PATH="${JAVA_HOME}/include"
		)
	fi

	cmake_src_configure
}

src_compile() {
	einfo "Generating TL source files"
	cmake_build tl_generate_common tl_generate_json

	if ! use jumbo-build; then
		einfo "Splitting source files"
		edo php SplitSource.php
	fi

	# Let's build the library
	einfo "Building TDLib"
	cmake_src_compile

	if use doc; then
		einfo "Generating docs"
		docs_compile
	fi
}

src_install() {
	cmake_src_install

	docompress -x /usr/share/doc/${PF}/example
	dodoc -r example

	if ! use static-libs; then
		einfo "Removing static libraries"
		find "${D}" -type f -name '*.a' -delete || die
	fi
}
