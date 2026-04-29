# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_OPTIONAL="1"

inherit zig

DESCRIPTION="OXWM — DWM but better. Dynamic window manager written in Zig with Lua config"
HOMEPAGE="https://github.com/tonybanters/oxwm"
SRC_URI="https://github.com/tonybanters/oxwm/archive/4670ae7.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0.15"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
	media-libs/fontconfig
	media-libs/freetype
	dev-lang/lua
"

DEPEND="${RDEPEND}"

BDEPEND="
    ${RDEPEND}
    dev-lang/zig
    virtual/pkgconfig
"

S="${WORKDIR}/oxwm-4670ae7"

src_configure() {
	zig_src_configure
}

src_compile() {
	zig_src_compile -Doptimize=ReleaseSmall
}

src_install() {
	zig_src_install

	insinto /usr/share/xsessions
	doins "${S}/resources/oxwm.desktop" 2>/dev/null || true

	insinto /usr/share/oxwm
	doins -r "${S}/templates"

	doman "${S}/resources/oxwm.1" 2>/dev/null || true
}

pkg_postinst() {
	elog "OXWM ${PV} installed successfully!"
	elog
	elog "First launch will create ~/.config/oxwm/config.lua"
	elog "Or manually run: oxwm --init"
	elog
	elog "Reload config anytime with: Super + Shift + R"
}
