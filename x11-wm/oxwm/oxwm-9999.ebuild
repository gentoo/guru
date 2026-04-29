# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_OPTIONAL="1"

inherit git-r3 zig

DESCRIPTION="OXWM — DWM but better. Dynamic window manager written in Zig with Lua config"
HOMEPAGE="https://github.com/tonybanters/oxwm"
EGIT_REPO_URI="https://github.com/tonybanters/oxwm.git"

LICENSE="GPL-3"
SLOT="0"

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

src_unpack() {
	git-r3_src_unpack
}

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
	elog "OXWM installed successfully!"
	elog
	elog "First launch will create ~/.config/oxwm/config.lua"
	elog "Or manually run: oxwm --init"
	elog
	elog "Reload config anytime with: Super + Shift + R"
}
