# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit cargo git-r3 cmake python-any-r1 xdg

DESCRIPTION="DDraceNetwork, a cooperative racing mod of Teeworlds "
HOMEPAGE="https://ddnet.org/
	https://github.com/ddnet/ddnet"

#SRC_URI="$(cargo_crate_uris ${CRATES})"
EGIT_REPO_URI="https://github.com/ddnet/ddnet"
EGIT_BRANCH="master"
EGIT_MIN_CLONE_TYPE="shallow"
EGIT_CHECKOUT_DIR=${WORKDIR}/${P}
EGIT_SUBMODULES=()

LICENSE="CC-BY-SA-3.0 OFL-1.1 BSD"
SLOT="0"
IUSE="antibot autoupdate +client download-gtest headless-client +inform-update +server +tools upnp +videorecorder vulkan websockets"
KEYWORDS=""

DEPEND="
	client? (
		media-libs/freetype
		media-libs/glew
		media-libs/libogg
		media-libs/libsdl2
		media-libs/opus
		media-libs/opusfile
		media-libs/pnglite
		videorecorder? ( media-video/ffmpeg )
	)
	dev-libs/glib
	dev-libs/openssl
	dev-db/sqlite
	download-gtest? (
		dev-cpp/gtest
		dev-vcs/git
	)
	media-libs/libglvnd
	media-libs/libpng
	media-sound/wavpack
	net-misc/curl
	upnp? ( net-libs/miniupnpc )
	vulkan? (
		media-libs/vulkan-loader
		media-libs/libsdl2[vulkan]
	)
	websockets? ( net-libs/libwebsockets[client] )
	x11-libs/gdk-pixbuf
	x11-libs/libnotify
	<=x11-libs/libX11-1.8.2
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/python-3.9
	dev-util/cmake
	dev-util/glslang
	dev-util/spirv-tools
	media-libs/x264
"

src_unpack() {
	default_src_unpack

	git-r3_fetch
	git-r3_checkout

	cargo_live_src_unpack
}

src_configure(){
	local mycmakeargs=(
		-DANTIBOT=$(usex antibot ON OFF)
		-DAUTOUPDATE=$(usex autoupdate ON OFF)
		-DCLIENT=$(usex client ON OFF)
		-DDOWNLOAD_GTEST=$(usex download-gtest ON OFF)
		-DHEADLESS_CLIENT=$(usex headless-client ON OFF)
		-DINFORM_UPDATE=$(usex inform-update ON OFF)
		-DSERVER=$(usex server ON OFF)
		-DTOOLS=$(usex tools ON OFF)
		-DUPNP=$(usex upnp ON OFF)
		-DVIDEORECORDER=$(usex videorecorder ON OFF)
		-DVULKAN=$(usex vulkan ON OFF)
		-DWEBSOCKETS=$(usex websockets ON OFF)
	)
	cmake_src_configure
}
