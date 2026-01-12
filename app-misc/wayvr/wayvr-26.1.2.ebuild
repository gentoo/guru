# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=({15..21})

inherit cargo desktop

DESCRIPTION="Access your Wayland/X11 desktop from Monado/WiVRn/SteamVR."
HOMEPAGE="https://github.com/wlx-team/wayvr"
SRC_URI="
	https://github.com/wlx-team/wayvr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/wlx-team/wayvr/releases/download/v${PV}/vendor.tar.xz -> ${P}-vendor.tar.xz
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0
	ISC MIT MPL-2.0 UoI-NCSA Unicode-3.0 Unlicense ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="
	|| ( openvr openxr )
	|| ( wayland X )
	wayland? ( pipewire )
"

IUSE="+openvr +openxr +wayland +X +pipewire +osc"

DEPEND="
	media-libs/alsa-lib
	media-libs/shaderc
	media-libs/fontconfig
	sys-apps/dbus
	media-libs/freetype
	X? (
		x11-libs/libxcb
		x11-libs/libxkbcommon[X]
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
	)
	openvr? (
		=media-libs/openvr-1.23.8-r0
	)
	openxr? (
		media-libs/openxr-loader[X?,wayland?]
	)
	pipewire? (
		media-video/pipewire
	)
	wayland? (
		x11-libs/libxkbcommon[wayland]
	)
"
BDEPEND="
	virtual/pkgconfig
"
RDEPEND="${DEPEND}"

src_unpack()
{
	cargo_src_unpack

	ln -s "${WORKDIR}/vendor/"* "${CARGO_HOME}/gentoo/"

	sed -i "${ECARGO_HOME}/config.toml" -e '/source.crates-io/d'  || die
	sed -i "${ECARGO_HOME}/config.toml" -e '/replace-with = "gentoo"/d'  || die
	sed -i "${ECARGO_HOME}/config.toml" -e '/local-registry = "\/nonexistent"/d'  || die

	cat "${WORKDIR}/vendor/vendor-config.toml" >> "${ECARGO_HOME}/config.toml" || die
}

src_configure() {
	local myfeatures=(
		$(usev openvr)
		$(usev openxr)
		$(usev wayland)
		$(usev X x11)
		$(usev pipewire)
		$(usev osc)
	)
	cargo_src_configure --no-default-features
}

src_install()
{
	doicon --size 256 wayvr/wayvr.png
	doicon --size scalable wayvr/wayvr.svg
	domenu wayvr/wayvr.desktop

	cargo_src_install --frozen --path wayvr
	#FIXME: wayvrcl fails to install as it tries to use the same features as wayvr itself
	#cargo_src_install --frozen --path wayvrctl
}
