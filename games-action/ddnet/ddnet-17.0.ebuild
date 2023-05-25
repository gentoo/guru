# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

CRATES="
cc-1.0.73
cxx-1.0.71
cxxbridge-flags-1.0.71
cxxbridge-macro-1.0.71
link-cplusplus-1.0.6
proc-macro2-1.0.40
quote-1.0.20
syn-1.0.98
unicode-ident-1.0.1
"

inherit cargo cmake python-any-r1 xdg

DESCRIPTION="DDraceNetwork, a cooperative racing mod of Teeworlds "
HOMEPAGE="https://ddnet.org/
	https://github.com/ddnet/ddnet"
SRC_URI="https://github.com/ddnet/ddnet/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris ${CRATES})"

LICENSE="CC-BY-SA-3.0 OFL-1.1 BSD"
SLOT="0"
IUSE="antibot autoupdate +client download-gtest headless-client +inform-update +server +tools upnp +videorecorder vulkan websockets"
KEYWORDS="~amd64"

DEPEND="
	client? (
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
	sys-libs/zlib
	dev-libs/openssl
	dev-db/sqlite
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
	dev-util/cmake
	dev-util/glslang
	dev-util/spirv-tools
"

src_unpack() {
	default_src_unpack
	cargo_src_unpack
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
		-DSECURITY_COMPILER_FLAGS=OFF # Set by gentoo toolchain, see https://bugs.gentoo.org/888875
	)
	cmake_src_configure
}
