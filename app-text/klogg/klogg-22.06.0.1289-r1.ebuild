# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="A GUI application to browse and search through long and complex log files"
HOMEPAGE="https://klogg.filimonov.dev"
MAJOR_VERSION=22.06
SRC_URI="
	https://github.com/variar/klogg/archive/refs/tags/v${MAJOR_VERSION}.tar.gz -> ${P}.tar.gz
	https://github.com/variar/klogg/releases/download/v${MAJOR_VERSION}/${P}.deps.tar.gz
	"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="lto test kde"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtconcurrent:5
	dev-libs/vectorscan:=
	>=dev-libs/xxhash-0.8.0
	>=app-i18n/uchardet-0.0.7
	>=dev-cpp/tbb-2021.5
	kde? ( kde-frameworks/karchive:5 )
"
RDEPEND="
	${DEPEND}
	x11-themes/hicolor-icon-theme
"
BDEPEND="
	>=dev-cpp/robin-hood-hashing-3.11.5
	test? ( dev-qt/qttest:5 >=dev-cpp/catch-2.13.8 )
"

PATCHES=(
	"${FILESDIR}/${P}-missing-include.patch"
)

src_unpack() {
	unpack ${P}.tar.gz
	mv "${WORKDIR}/${PN}-${MAJOR_VERSION}" "${WORKDIR}/${P}"

	unpack ${P}.deps.tar.gz
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	export KLOGG_VERSION=${PV}
	local mycmakeargs=(
		-DCPM_SOURCE_CACHE="${WORKDIR}/cpm_cache"
		-DCPM_USE_LOCAL_PACKAGES=ON
		-DWARNINGS_AS_ERRORS=OFF
		-DKLOGG_USE_LTO=$(usex lto)
		-DKLOGG_BUILD_TESTS=$(usex test)
		-DKLOGG_USE_MIMALLOC=OFF
		-DKLOGG_USE_SENTRY=OFF
	)

	cmake_src_configure
}
