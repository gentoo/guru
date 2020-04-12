# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alemart/opensurge"
else
	SRC_URI="https://github.com/alemart/opensurge/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="fun 2D retro platformer inspired by old-school Sonic games"
HOMEPAGE="https://opensurge2d.org/"
LICENSE="GPL-3"
SLOT="0"

# Allegro:5 libs to USE
# - image: jpeg,png
# - primitives: opengl
# - font+ttf: truetype
# - acodec+audio: alsa/openal/oss/pulseaudio (present in REQUIRED_USE)
# - dialog: gtk
# allegro[vorbis] isn't in CMakeList.txt but is required for the .ogg assets
DEPEND="
	>=media-libs/allegro-5.2.5:=
	media-libs/allegro[jpeg,png,opengl,truetype,gtk,vorbis]
	>=dev-games/surgescript-0.5.4.3:=
"
RDEPEND="${DEPEND}"

# https://github.com/alemart/opensurge/pull/30
PATCHES=( "${FILESDIR}/${P}-fix_executable_install_path.patch" )

src_configure() {
	local mycmakeargs=(
		-DUSE_STATIC=OFF
	)

	cmake_src_configure
}
