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

LICENSE="MIT"
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
	virtual/zlib:=
"
DEPEND="$RDEPEND
	test? ( dev-qt/qtbase:6[test] )
"

DOCS=( NOTES.txt README.md RELEASES.txt )
PATCHES=(
	"${FILESDIR}/${PN}-1.4.0.0-minor-fix-remove-extention-from-Icon-endtry-in-a-des.patch"
	"${FILESDIR}/${P}-Minimal-cmake-fixes.patch"
	"${FILESDIR}/${P}-Make-building-of-tests-optional.patch"
	"${FILESDIR}/${P}-Make-runtime-respect-cmake-s-plugin-dir-settings.patch"
	"${FILESDIR}/${P}-Fix-translation-install-path-on-nix.patch"
)

src_configure() {
	local mycmakeargs=(
		-DPDF4QT_INSTALL_DEPENDENCIES=OFF
		-DPDF4QT_INSTALL_TO_USR=OFF
		-DPDF4QT_BUILD_TESTS="$(usex test)"
		-DVCPKG_OVERLAY_PORTS="" # suppress a warning
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/bin/UnitTests || die "tests failed"
}
