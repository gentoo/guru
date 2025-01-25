# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="Open source PDF WYSIWYG editor based on Qt"
HOMEPAGE="https://jakubmelka.github.io/"
MY_PN="${PN^^}"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/JakubMelka/${MY_PN}"
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/JakubMelka/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/${MY_P}
fi

LICENSE="LGPL-3+"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/tbb:=
	dev-libs/openssl
	dev-qt/qtbase:6[gui,widgets,xml]
	dev-qt/qtspeech:6
	dev-qt/qtsvg:6
	media-libs/blend2d
	media-libs/freetype
	media-libs/lcms
	media-libs/libjpeg-turbo
	media-libs/openjpeg
	sys-libs/zlib
"
DEPEND="$RDEPEND
	test? ( dev-qt/qtbase:6[test] )
"

DOCS=( NOTES.txt README.md RELEASES.txt )
PATCHES=(
	"${FILESDIR}/pdf4qt-1.4.0.0-minor-fix-remove-extention-from-Icon-endtry-in-a-des.patch"
	"${FILESDIR}/pdf4qt-1.4.9999-Minimal-cmake-fixes.patch"
	"${FILESDIR}/pdf4qt-1.4.0.0-Make-runtime-respect-cmake-s-plugin-dir-settings.patch"
)

src_prepare() {
	cmake_src_prepare

	# Conditionally dissable test build
	if ! use test; then
		sed -i -e '/find_package(Qt6/s/Test//' \
			   -e '/add_subdirectory(UnitTests)/d' \
			CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DPDF4QT_INSTALL_DEPENDENCIES=OFF
		-DPDF4QT_INSTALL_TO_USR=OFF
		-DVCPKG_OVERLAY_PORTS="" # suppress a warning
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/bin/UnitTests || die "tests failed"
}
