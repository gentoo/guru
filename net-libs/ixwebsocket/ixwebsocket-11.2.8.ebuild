# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_P="IXWebSocket-${PV}"

DESCRIPTION="C++ websocket client and server library"
HOMEPAGE="https://github.com/machinezone/IXWebSocket"
SRC_URI="https://github.com/machinezone/IXWebSocket/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ssl test zlib ws"

DEPEND="
	sys-libs/zlib:=

	ws? (
		>=dev-libs/spdlog-1.8.0:=
	)
	test? (
		>=dev-libs/spdlog-1.8.0:=
	)
"
RDEPEND="
	sys-libs/zlib:=
"
BDEPEND=""

S="${WORKDIR}/${MY_P}"

RESTRICT="!test? ( test )"

PATCHES=(
	# Upstream installs to hardcoded lib- and include-dirs
	"${FILESDIR}/${P}-use-gnuinstalldirs.patch"
	# Some tests require network connectivity
	"${FILESDIR}/${P}-remove-network-tests.patch"
	# Upstream uses git submodules
	"${FILESDIR}/${P}-use-system-spdlog.patch"
	# Upstream detects deflate dynamically, so let's remove it
	"${FILESDIR}/${P}-remove-deflate.patch"
)

src_configure() {
	local mycmakeargs=(
		-DUSE_TLS="$(usex ssl)"
		-DUSE_ZLIB="$(usex zlib)"
		-DUSE_WS="$(usex ws)"
		-DUSE_TEST="$(usex test)"
	)
	cmake_src_configure
}

src_test() {
	cd "${BUILD_DIR}" || die
	ctest --output-on-failure || die
}
