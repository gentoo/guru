# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="An LV2 audio plugin implementing a powerful and flexible parametric equalizer"
HOMEPAGE="https://eq10q.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/project/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/gtkmm:2.4
	media-libs/lv2
	sci-libs/fftw:3.0=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-2.2-flags.patch
	"${FILESDIR}"/${PN}-2.2-cmake4.patch
	"${FILESDIR}"/${PN}-2.2-pow10.patch
	"${FILESDIR}"/${PN}-2.2-fix-lv2-types.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/$(get_libdir)/lv2"
	)

	cmake_src_configure
}
