# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="A Wayland Native VNC Client"
HOMEPAGE="https://github.com/any1/wlvncc"
EGIT_REPO_URI="https://github.com/any1/wlvncc"
LICENSE="GPL-2"
SLOT="0"

DOCS=("README.md" "scripts/auth-script.sh")

DEPEND="
	dev-libs/wayland-protocols
"
RDEPEND="
	dev-libs/aml
	x11-libs/libxkbcommon
	x11-libs/pixman
	dev-libs/wayland
"
