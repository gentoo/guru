# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{12..15})
RUST_MIN_VER="1.85.0"

CRATES="
anstyle@1.0.14
cc@1.2.29
clap@4.6.1
clap_builder@4.6.0
clap_lex@1.1.0
codespan-reporting@0.13.1
cxx@1.0.194
cxx-build@1.0.194
cxxbridge-cmd@1.0.194
cxxbridge-flags@1.0.194
cxxbridge-macro@1.0.194
equivalent@1.0.2
foldhash@0.2.0
hashbrown@0.17.1
indexmap@2.14.0
libc@0.2.183
link-cplusplus@1.0.12
proc-macro2@1.0.103
quote@1.0.41
scratch@1.0.9
serde@1.0.228
serde_core@1.0.228
serde_derive@1.0.228
shlex@1.3.0
strsim@0.11.1
syn@2.0.106
termcolor@1.4.1
unicode-ident@1.0.1
unicode-width@0.2.2
winapi-util@0.1.11
windows-link@0.2.1
windows-sys@0.61.2
"

inherit cargo cmake python-any-r1 xdg

DESCRIPTION="DDraceNetwork, a cooperative racing mod of Teeworlds "
HOMEPAGE="https://ddnet.org/
	https://github.com/ddnet/ddnet"
SRC_URI="https://github.com/ddnet/ddnet/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
${CARGO_CRATE_URIS}"

LICENSE="CC-BY-SA-3.0 OFL-1.1 BSD"
SLOT="0"
KEYWORDS="~amd64"

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
	dev-libs/glib
	virtual/zlib:=
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
BDEPEND="${BDEPEND}
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
	cargo_src_unpack
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
