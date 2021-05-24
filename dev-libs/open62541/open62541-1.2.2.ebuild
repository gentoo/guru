# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit cmake python-single-r1

DESCRIPTION="Open source C implementation of OPC UA"
HOMEPAGE="https://open62541.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="doc encryption examples etf mbedtls pubsub openssl test tools xdp"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	encryption? ( || ( mbedtls openssl ) )
	etf? ( pubsub )
	xdp? ( pubsub )
"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? (
		media-gfx/graphviz
		$(python_gen_cond_dep '
			dev-python/sphinx[${PYTHON_MULTI_USEDEP}]
			dev-python/sphinx_rtd_theme[${PYTHON_MULTI_USEDEP}]
		')
	)
	test? (
		dev-libs/check
		dev-util/valgrind
		$(python_gen_cond_dep '
			dev-python/subunit[${PYTHON_MULTI_USEDEP}]
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

PATCHES=(
	"${FILESDIR}/${P}-headers.patch"
	"${FILESDIR}/${P}-tests.patch"
)

src_prepare() {
	# bug 780912
	sed -i -e 's/check_add_cc_flag("-Werror")//g' CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DOPEN62541_VERSION=v${PV}
		-DUA_BUILD_EXAMPLES=OFF
		-DUA_BUILD_TOOLS=$(usex tools)
		-DUA_BUILD_UNIT_TESTS=$(usex test)
		-DUA_ENABLE_ENCRYPTION=$(usex encryption)
		-DUA_ENABLE_ENCRYPTION_MBEDTLS=$(usex mbedtls)
		-DUA_ENABLE_ENCRYPTION_OPENSSL=$(usex openssl)
		-DUA_ENABLE_PUBSUB=$(usex pubsub)
		-DUA_ENABLE_PUBSUB_ETH_UADP=$(usex pubsub)
		-DUA_ENABLE_PUBSUB_ETH_UADP_ETF=$(usex etf)
		-DUA_ENABLE_PUBSUB_ETH_UADP_XDP=$(usex xdp)
	)

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

	python_fix_shebang "${ED}"
}

src_test() {
	cmake_src_test -j1
}
