# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Generates AppImage thumbnails for Linux desktops"
HOMEPAGE="https://github.com/kem-a/appimage-thumbnailer"
SRC_URI="https://github.com/kem-a/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	gnome-base/librsvg:2
	sys-fs/dwarfs
	sys-fs/squashfs-tools
	x11-libs/cairo"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local emesonargs=(
		-Dbundle_dwarfs=false
		-Dbundle_squashfs=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	einstalldocs
}
