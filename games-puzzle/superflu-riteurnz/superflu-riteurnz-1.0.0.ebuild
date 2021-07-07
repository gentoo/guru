# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MY_P="sosage-v${PV}"
MY_DATA_P="superflu-riteurnz-v1.0.0-xmas2020demo-data"

DESCRIPTION="Artisanal video-game about Superflu, the useless super-hero (french)"
HOMEPAGE="https://ptilouk.net/superflu-riteurnz/"
SRC_URI="
	https://framagit.org/Gee/sosage/-/archive/v${PV}/${MY_P}.tar.gz
	https://ptilouk.net/superflu-riteurnz/superflu-riteurnz-v1.0.0-xmas2020demo-data.zip
"
S="${WORKDIR}/${MY_P}"
LICENSE="CC-BY-SA-2.0 GPL-3+ CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libyaml
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/sdl2-image
	media-libs/sdl2-ttf
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

src_configure() {
	local mycmakeargs=(
		-DSOSAGE_DATA_FOLDER="${WORKDIR}/${MY_DATA_P}"
	)

	cmake_src_configure
}
