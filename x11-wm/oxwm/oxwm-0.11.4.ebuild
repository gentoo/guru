# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OXWM — DWM but better. Dynamic window manager written in Zig with Lua config"
HOMEPAGE="https://github.com/tonybanters/oxwm"

COMMIT="f699f6d1ff9e07cdd3831591bda84400e784b2c1"

SRC_URI="https://codeload.github.com/tonybanters/oxwm/tar.gz/${COMMIT} -> ${P}.tar.gz"

S="${WORKDIR}/oxwm-${COMMIT}"

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

DEPEND="
    ${RDEPEND}
    dev-lang/zig
"

BDEPEND="
    virtual/pkgconfig
"

src_unpack() {
    default
    local unpacked_dir
    unpacked_dir=$(find "${WORKDIR}" -maxdepth 1 -type d -name "oxwm-*" | head -n1) || die "Source folder not found"
    if [[ "${unpacked_dir}" != "${WORKDIR}/${P}" ]]; then
        mv "${unpacked_dir}" "${WORKDIR}/${P}" || die "Failed to rename source folder"
    fi
    S="${WORKDIR}/${P}"
}

src_configure() {
    mkdir -p build
    cd build || die
    zig build -Doptimize=ReleaseSmall
}

src_compile() {
    cd build || die
    zig build -Doptimize=ReleaseSmall
}

src_install() {
    cd build || die
    zig build install
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
