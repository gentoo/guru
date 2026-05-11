# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_MIN_VERSION="0.15.0"
ZIG_SLOT="0.15"
ZIG_INSOURCE_BUILD=1

inherit zig

DESCRIPTION="OXWM — DWM but better. Dynamic window manager written in Zig with Lua config"
HOMEPAGE="https://github.com/tonybanters/oxwm"

COMMIT="f699f6d1ff9e07cdd3831591bda84400e784b2c1"
SRC_URI="https://codeload.github.com/tonybanters/oxwm/tar.gz/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
	media-libs/fontconfig
	media-libs/freetype
	dev-lang/lua
"
DEPEND="${RDEPEND}"

src_unpack() {
	default
	local unpacked_dir
	unpacked_dir=$(find "${WORKDIR}" -maxdepth 1 -type d -name "oxwm-*" | head -n1) \
		|| die "Source folder not found"
	mv "${unpacked_dir}" "${WORKDIR}/${P}" || die "Failed to rename source folder"
}

src_configure() {
	# Use eclass's configure to set up prefix, libc, etc.
	zig_src_configure
}

src_compile() {
	# Build in the source tree (forced by ZIG_INSOURCE_BUILD already,
	# but explicitly cd there to be safe) with ReleaseSmall.
	cd "${S}" || die
	ezig build -Doptimize=ReleaseSmall || die "Build failed"
}

src_install() {
	# Let eclass install from the build (it will go to zig-out)
	zig_src_install

	insinto /usr/share/xsessions
	doins "${S}/resources/oxwm.desktop" 2>/dev/null || true

	insinto /usr/share/oxwm
	doins -r "${S}/templates"

	doman "${S}/resources/oxwm.1" 2>/dev/null || true
}

pkg_postinst() {
	elog "OXWM installed successfully!"
	elog "First launch will create ~/.config/oxwm/config.lua"
	elog "Or run: oxwm --init"
}