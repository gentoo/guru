# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit cmake python-single-r1

DESCRIPTION="Open source C implementation of OPC UA"
HOMEPAGE="https://www.open62541.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="doc encryption examples mbedtls pubsub openssl tools"
# Requires network access
RESTRICT="test"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	encryption? ( || ( mbedtls openssl ) )
"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? (
		media-gfx/graphviz
		$(python_gen_cond_dep '
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		')
	)
"
DEPEND="
	mbedtls? ( net-libs/mbedtls:= )
	openssl? ( dev-libs/openssl:0= )
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DOPEN62541_VERSION=v${PV}
		-DUA_BUILD_EXAMPLES=OFF
		-DUA_BUILD_TOOLS=$(usex tools)
		-DUA_BUILD_UNIT_TESTS=OFF
		-DUA_ENABLE_PUBSUB=$(usex pubsub)
		-DUA_FORCE_WERROR=OFF
	)

	if use encryption; then
		use mbedtls && mycmakeargs+=(-DUA_ENABLE_ENCRYPTION=MBEDTLS)
		use openssl && mycmakeargs+=(-DUA_ENABLE_ENCRYPTION=OPENSSL)
	fi

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_build doc
}

src_install() {
	use doc && local HTML_DOCS=( "${WORKDIR}"/${P}_build/doc/. )
	cmake_src_install

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples/
	fi
}

src_test() {
	cmake_src_test -j1
}
