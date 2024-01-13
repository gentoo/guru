# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
DOCS_DEPEND="app-text/doxygen[dot]"
DOCS_CONFIG_NAME="the_Foundation.doxygen"
inherit cmake docs

MY_PN="the_foundation"
DESCRIPTION="Opinionated C11 library for low-level functionality"
HOMEPAGE="https://git.skyjake.fi/skyjake/the_Foundation"
SRC_URI="https://git.skyjake.fi/skyjake/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}"

LICENSE="BSD-2"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse4_1 curl debug ssl"

DEPEND="
	dev-libs/libpcre2:=
	dev-libs/libunistring:=
	sys-libs/zlib:=
	curl? ( net-misc/curl )
	ssl? ( dev-libs/openssl:= )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DTFDN_ENABLE_WARN_ERROR=OFF
		-DTFDN_ENABLE_DEBUG_OUTPUT=$(usex debug)
		-DTFDN_ENABLE_SSE41=$(usex cpu_flags_x86_sse4_1)
		-DTFDN_ENABLE_TESTS=OFF  # not actual tests
		-DTFDN_ENABLE_TLSREQUEST=$(usex ssl)
		-DTFDN_ENABLE_WEBREQUEST=$(usex curl)
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}
