# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{11..12})

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

DEPEND="
	client? (
		media-libs/libglvnd
		media-libs/freetype
		media-libs/glew
		media-libs/libogg
		media-libs/libsdl2
		media-libs/opus
		media-libs/opusfile
		media-libs/libpng
		media-libs/x264
		media-sound/wavpack
		x11-libs/libnotify
		videorecorder? ( media-video/ffmpeg )
	)
	dev-libs/openssl
	dev-db/sqlite
	dev-libs/glib
	download-gtest? (
		dev-cpp/gtest
		dev-vcs/git
	)
	net-misc/curl
	upnp? ( net-libs/miniupnpc )
	vulkan? (
		media-libs/vulkan-loader
		media-libs/libsdl2[vulkan]
	)
	websockets? ( net-libs/libwebsockets[client] )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/python-3.9
	dev-util/glslang
	dev-util/spirv-tools
"

pkg_setup() {
	python-any-r1_pkg_setup
	rust_pkg_setup
}

src_unpack() {
	default_src_unpack

	git-r3_fetch
	git-r3_checkout

	cargo_live_src_unpack
}

src_configure() {
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
		-DSECURITY_COMPILER_FLAGS=OFF # Set by gentoo toolchain, see https://bugs.gentoo.org/888875
	)
	cmake_src_configure
}
