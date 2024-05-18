# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ library to communicate with Microsoft SQL server"
HOMEPAGE="https://github.com/maharmstone/tdscpp"
SRC_URI="https://codeload.github.com/maharmstone/tdscpp/tar.gz/refs/tags/${PV} -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"
IUSE="kerberos +ssl"

DEPEND="dev-cpp/nlohmann_json
	dev-libs/icu
	kerberos? ( virtual/krb5 )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_KRB5="$(usex kerberos)"
		-DWITH_OPENSSL="$(usex ssl)"
		-DBUILD_SAMPLE=OFF
	)

	cmake_src_configure
}
