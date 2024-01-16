# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Non-blocking I/O tcp network lib based on c++14/17"
HOMEPAGE="https://github.com/an-tao/trantor"
SRC_URI="https://github.com/an-tao/trantor/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="adns doc +spdlog +ssl test"
RESTRICT="!test? ( test )"

RDEPEND="
	adns? ( net-dns/c-ares:= )
	ssl? ( dev-libs/openssl:= )
	spdlog? (
		dev-libs/spdlog:=
		dev-libs/libfmt:=
	)
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"
BDEPEND="doc? ( app-text/doxygen[dot] )"

src_prepare() {
	sed -i 's/ -Werror)$/)/' CMakeLists.txt || die "could not remove -Werror"
	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		"-DBUILD_SHARED_LIBS=YES"
		"-DBUILD_DOC=$(usex doc)"
		"-DBUILD_TESTING=$(usex test)"
		"-DBUILD_C-ARES=$(usex adns)"
		"-DTRANTOR_USE_TLS=$(usex ssl openssl none)"
		"-DUSE_SPDLOG=$(usex spdlog)"
	)

	cmake_src_configure
}

src_install() {
	use doc && HTML_DOCS="${BUILD_DIR}/docs/trantor/html/*"

	cmake_src_install
}
