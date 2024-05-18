# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_P="sosage-v${PV}"

DESCRIPTION="Artisanal video-game about Superflu, the useless super-hero"
HOMEPAGE="https://studios.ptilouk.net/superflu-riteurnz/"
SRC_URI="https://framagit.org/Gee/sosage/-/archive/v${PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
# Engine under GPL-3+ + assets under all-rights-reserved are combined together
LICENSE="GPL-3+ all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist"

PATCHES=(
	"${FILESDIR}/superflu-riteurnz-1.5.4-add-missing-include-functional.patch"
	"${FILESDIR}/superflu-riteurnz-1.5.4-add-missing-include-initializer_list.patch"
)

BDEPEND="app-arch/unzip"
DEPEND="
	dev-libs/libyaml
	app-arch/lz4
	>=media-libs/libsdl2-2.0.14
	media-libs/sdl2-mixer
	media-libs/sdl2-image
	media-libs/sdl2-ttf
	>=games-puzzle/superflu-riteurnz-data-11:=
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=( -DSOSAGE_DATA_FOLDER="/usr/share/superflu-riteurnz-data" )

	cmake_src_configure
}
