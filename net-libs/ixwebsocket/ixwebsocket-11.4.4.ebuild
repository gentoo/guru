# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_P="IXWebSocket-${PV}"

DESCRIPTION="C++ websocket client and server library"
HOMEPAGE="https://github.com/machinezone/IXWebSocket"
SRC_URI="https://github.com/machinezone/IXWebSocket/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/11.3.2"
KEYWORDS="~amd64 ~x86"
IUSE="+ssl test zlib ws"

DEPEND="
	ssl? (
		dev-libs/openssl:=
	)
	ws? (
		>=dev-libs/spdlog-1.8.0:=
	)
	zlib? (
		sys-libs/zlib:=
	)
	test? (
		>=dev-libs/spdlog-1.8.0:=
	)
"
RDEPEND="
	ssl? (
		dev-libs/openssl:=
	)
	zlib? (
		sys-libs/zlib:=
	)
"
BDEPEND=""

S="${WORKDIR}/${MY_P}"

RESTRICT="!test? ( test )"

PATCHES=(
	# Some tests require network connectivity
	"${FILESDIR}/${P}-remove-network-tests.patch"
	# Upstream uses git submodules
	"${FILESDIR}/${P}-use-system-spdlog.patch"
	# Fix Server empty thread name
	"${FILESDIR}/${P}-fix-server-empty-thread-name.patch"
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
