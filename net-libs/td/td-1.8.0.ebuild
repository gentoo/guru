# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
inherit cmake docs java-pkg-opt-2

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="
	https://core.telegram.org/tdlib
	https://github.com/tdlib/td
"
SRC_URI="https://github.com/tdlib/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dotnet +jumbo-build static-libs test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/openssl:=
	sys-libs/zlib:=
	dotnet? ( virtual/dotnet-sdk:* )
	java? ( >=virtual/jdk-11:*[-headless-awt] )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/php[cli]
	dev-util/gperf
"

DOCS=( CHANGELOG.md README.md )

TEST_TARGETS=(
	test-crypto
	#test-online -- requires network
	#test-tdutils -- hangs
	#run_all_tests -- segfaults
)

src_prepare() {
	sed "/find_program(CCACHE_FOUND ccache)/d" -i CMakeLists.txt || die
	echo "" > gen_git_commit_h.sh || die

	cmake_comment_add_subdirectory benchmark
	use test || \
		cmake_comment_add_subdirectory test

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTD_ENABLE_DOTNET=$(usex dotnet)
	)

	if use java; then
		mycmakeargs+=(
			-DTD_ENABLE_JNI=ON
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
	einfo "Generating TL source file"
	cmake_build tl_generate_common tl_generate_json

	einfo "Generating git_info.h"
	cat <<- EOF > auto/git_info.h || die
	#pragma once
	#define GIT_COMMIT "v${PV}"
	#define GIT_DIRTY 0
	EOF

	if ! use jumbo-build; then
		einfo "Splitting source files"
		php SplitSource.php || die
	fi

	# Let's build the library
	einfo "Building TDLib"
	cmake_src_compile

	if use test; then
		einfo "Building tests"
		cmake_build "${TEST_TARGETS[@]}"
	fi

	if use doc; then
		einfo "Generating docs"
		docs_compile
	fi
}

src_test() {
	# segfault
	#cmake_src_test

	pushd "${BUILD_DIR}"/test > /dev/null || die
	for exe in "${TEST_TARGETS[@]}"; do
		einfo "Running ${exe}"
		./"${exe}" || die "${exe} failed"
	done
	popd > /dev/null || die
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
