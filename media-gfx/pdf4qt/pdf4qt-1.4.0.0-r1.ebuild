# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg-utils

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
DEPEND="$RDEPEND"

DOCS=( NOTES.txt README.md RELEASES.txt )
PATCHES=(
	"${FILESDIR}/pdf4qt-1.4.0.0-fix-build-failure-on-resetMatrix.patch"
	"${FILESDIR}/pdf4qt-1.4.0.0-minor-fix-remove-extention-from-Icon-endtry-in-a-des.patch"
	"${FILESDIR}/pdf4qt-1.4.0.0-Minimal-cmake-fixes.patch"
	"${FILESDIR}/pdf4qt-1.4.0.0-Disable-test-building.patch"
	"${FILESDIR}/pdf4qt-1.4.0.0-Make-runtime-respect-cmake-s-plugin-dir-settings.patch"
)

src_configure() {
	local mycmakeargs=(
		-DPDF4QT_INSTALL_DEPENDENCIES=OFF
		-DPDF4QT_INSTALL_TO_USR=OFF
		-DVCPKG_OVERLAY_PORTS="" # suppress a warning
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
