# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

EGIT_REPO_URI="https://github.com/any1/wlvncc"

DESCRIPTION="A Wayland Native VNC Client"
HOMEPAGE="https://github.com/any1/wlvncc"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="
    dev-libs/aml
    x11-libs/libxkbcommon
    x11-libs/pixman
    dev-libs/wayland
"
BDEPEND="
    dev-libs/wayland-protocols
"

src_configure() {
    meson_src_configure
}

src_install() {
    meson_src_install
}
