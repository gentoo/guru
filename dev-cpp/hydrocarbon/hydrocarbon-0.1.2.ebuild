# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple, self-contained C++23 HTTP library"
HOMEPAGE="https://github.com/crueter/hydrocarbon"
SRC_URI="https://github.com/crueter/hydrocarbon/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# tests currently use httpbin, this will change eventually.
RESTRICT="test"

RDEPEND="
	dev-libs/openssl
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DHYDROCARBON_BUILD_TESTS=OFF
	)

	cmake_src_configure
}
