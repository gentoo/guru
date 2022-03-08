# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Thalhammer/jwt-cpp.git"
else
	SRC_URI="https://github.com/Thalhammer/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="header only library for creating and validating JSON Web Tokens in C++11"
HOMEPAGE="https://thalhammer.github.io/jwt-cpp/"

LICENSE="MIT"
SLOT="0"
IUSE="doc +picojson test"

DEPEND="${RDEPEND}
	dev-libs/openssl
	picojson? ( dev-cpp/picojson )"
BDEPEND="
	doc? ( app-doc/doxygen[dot] )
	test? ( dev-cpp/gtest )
"
RESTRICT="
	!picojson? ( test )
	!test? ( test )"

src_prepare() {
	# Unbundle dev-cpp/picojson and fix include paths.
	# See also: https://github.com/Thalhammer/jwt-cpp/issues/213
	rm -vrf include/picojson || die
	find -name '*.h' -type f -print0 | xargs -0 sed -r -e "s:picojson/picojson\.h:picojson.h:g" -i || die
	# Prevent installation of bundled dev-cpp/picojson.
	sed -i -e 's:^\s*install.*include/picojson.*$::' CMakeLists.txt || die
	# Fix installation paths for .cmake files.
	sed -i -e 's:DESTINATION ${CMAKE_INSTALL_PREFIX}/jwt-cpp:DESTINATION ${CMAKE_INSTALL_PREFIX}/share/jwt-cpp:' CMakeLists.txt || die
	sed -i -e 's:DESTINATION jwt-cpp:DESTINATION ${CMAKE_INSTALL_PREFIX}/share/jwt-cpp:' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
			# Not useful for now, asks for non-existent CMake module.
			#-DJWT_EXTERNAL_PICOJSON="$(usex picojson)"
			# Examples are not installed and for development only.
			-DBUILD_TESTS="$(usex test)"
			)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		doxygen || die
	fi
}

src_install() {
	cmake_src_install
	use doc && local HTML_DOCS=(docs/html/.)
	einstalldocs
}

src_test() {
	"${BUILD_DIR}"/tests/jwt-cpp-test || die
}
