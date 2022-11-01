# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="HTTP Framework for REST Applications in C"
HOMEPAGE="https://github.com/babelouest/ulfius/"
SRC_URI="https://github.com/babelouest/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl doc jansson ssl websocket"
RESTRICT="test"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	curl? ( net-misc/curl )
	doc? ( app-doc/doxygen )
	jansson? ( dev-libs/jansson:= )
	ssl? ( net-libs/gnutls:= )
	net-libs/libmicrohttpd:=
	net-libs/orcania
	sys-libs/zlib
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_ULFIUS_DOCUMENTATION=$(usex doc)
		-DDOWNLOAD_DEPENDENCIES=OFF
		-DWITH_CURL=$(usex curl)
		-DWITH_GNUTLS=$(usex ssl)
		-DWITH_JANSSON=$(usex jansson)
		-DWITH_WEBSOCKET=$(usex websocket)
		-DWITH_YDER=OFF
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_build doc
}

src_install() {
	use doc && local HTML_DOCS=( doc/html/* )
	cmake_src_install
}
