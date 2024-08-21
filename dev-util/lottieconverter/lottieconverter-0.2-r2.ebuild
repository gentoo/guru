# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple lottie (telegram animated sticker) converter"
HOMEPAGE="https://github.com/sot-tech/LottieConverter"
SRC_URI="https://github.com/sot-tech/${PN}/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/LottieConverter-r${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

DEPEND="
	media-libs/giflib:=
	media-libs/libpng:=
	media-libs/rlottie:=
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.2-buildtype.patch )

src_configure() {
	local mycmakeargs=(
		-DSYSTEM_PNG=ON
		-DSYSTEM_RL=ON
		-DSYSTEM_GL=ON
	)
	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}"/lottieconverter
	einstalldocs
}
