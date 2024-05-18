# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="a multi-system chiptune tracker compatible with DefleMask modules"
HOMEPAGE="https://github.com/tildearrow/furnace"

# when performing updates, check whether the project has switched to a new
# version of adpcm. adpcm doesn't seem to update frequently.
SRC_URI="
	https://github.com/tildearrow/furnace/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/superctr/adpcm/archive/ef7a217154badc3b99978ac481b268c8aab67bd8.tar.gz -> ${P}-adpcm-ef7a217.tar.gz
"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="jack"

RDEPEND="
	dev-libs/libfmt
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/libsdl2
	media-libs/libsndfile
	media-libs/portaudio
	media-libs/rtmidi
	sci-libs/fftw
	sys-libs/zlib
	x11-themes/hicolor-icon-theme
	jack? ( virtual/jack )
"
DEPEND="${RDEPEND}"

src_prepare() {
	# adpcm is a git submodule in-tree, and thus not included in the
	# github-generated source bundle. We move it in here.
	rmdir -v "${S}/extern/adpcm" || die "couldn't remove existing adpcm stub directory"
	mv -v "${WORKDIR}/adpcm-"* "${S}/extern/adpcm" || die "failed to move adpcm directory into place"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_GUI=ON
		-DSYSTEM_FFTW=ON
		-DSYSTEM_FMT=ON
		-DSYSTEM_LIBSNDFILE=ON
		-DSYSTEM_PORTAUDIO=ON
		-DSYSTEM_RTMIDI=ON
		-DSYSTEM_ZLIB=ON
		-DSYSTEM_SDL2=ON
		-DWITH_JACK="$(usex jack ON OFF)"
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
