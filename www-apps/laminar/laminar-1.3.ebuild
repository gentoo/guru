# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

CMAKE_BUILD_TYPE=Release
CMAKE_IN_SOURCE_BUILD=1

declare -A BUNDLED_VERSION_FOR
BUNDLED_VERSION_FOR[vue.min]=2.6.12
BUNDLED_VERSION_FOR[ansi_up]=4.0.4
BUNDLED_VERSION_FOR[Chart.min]=3.9.1

DESCRIPTION="Fast and lightweight Continuous Integration"
HOMEPAGE="https://laminar.ohwg.net https://github.com/ohwgiles/laminar"
SRC_URI="
	https://github.com/ohwgiles/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://cdnjs.cloudflare.com/ajax/libs/vue/${BUNDLED_VERSION_FOR[vue.min]}/vue.min.js -> ${P}-vue.min-${BUNDLED_VERSION_FOR[vue.min]}.js
	https://raw.githubusercontent.com/drudru/ansi_up/v${BUNDLED_VERSION_FOR[ansi_up]}/ansi_up.js -> ${P}-ansi_up-${BUNDLED_VERSION_FOR[ansi_up]}.js
	https://cdnjs.cloudflare.com/ajax/libs/Chart.js/${BUNDLED_VERSION_FOR[Chart.min]}/chart.min.js -> ${P}-Chart.min-${BUNDLED_VERSION_FOR[Chart.min]}.js
"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPS="
	dev-db/sqlite:3
	dev-libs/capnproto
	sys-libs/zlib
"

DEPEND="
	${COMMON_DEPS}
	dev-libs/boost
	dev-libs/rapidjson
	test? ( dev-cpp/gtest )
"

RDEPEND="
	${COMMON_DEPS}
	acct-group/laminar
	acct-user/laminar
"

PATCHES=(
	"${FILESDIR}/${P}-skip-js-download.patch"
	"${FILESDIR}/${P}-skip-manpage-compression.patch"
	"${FILESDIR}/${P}-fix-cmake-warning.patch"
)

src_unpack() {
	unpack "${P}.tar.gz"

	mkdir "${S}/js" || die

	local dep

	for dep in vue.min ansi_up Chart.min; do
		cp "${DISTDIR}/${P}-${dep}-${BUNDLED_VERSION_FOR[$dep]}.js" "${S}/js/${dep}.js" || die
	done
}

src_configure() {
	local mycmakeargs=(
		-DLAMINAR_VERSION=${PV}
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	./laminar-tests || die
}

src_install() {
	newinitd "${FILESDIR}/laminar.initd" laminar

	dosym -r /etc/laminar.conf /etc/conf.d/laminar

	cmake_src_install
}
