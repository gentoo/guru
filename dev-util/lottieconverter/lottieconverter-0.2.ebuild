# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Simple lottie (telegram animated sticker) converter."
HOMEPAGE="https://github.com/sot-tech/LottieConverter"
SRC_URI="https://github.com/sot-tech/${PN}/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

S="${WORKDIR}/LottieConverter-r0.2"

DEPEND="media-libs/rlottie media-libs/libpng media-libs/giflib"
RDEPEND="${DEPEND}"

src_configure() {
	# -DSYSTEM_PNG=0 -DSYSTEM_RL=1 -DSYSTEM_GL=0
	local mycmakeargs=(-DSYSTEM_PNG=1 -DSYSTEM_RL=1 -DSYSTEM_GL=1)
	cmake_src_configure
}

src_install() {
	dobin "${S}_build/lottieconverter"
}
