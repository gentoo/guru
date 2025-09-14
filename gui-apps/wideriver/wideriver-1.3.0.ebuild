# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tiling window manager for the river wayland compositor"
HOMEPAGE="https://github.com/alex-courtis/wideriver"
SRC_URI="https://github.com/alex-courtis/wideriver/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-libs/libinput
	gui-libs/wlroots
"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	dodoc README.md
}
