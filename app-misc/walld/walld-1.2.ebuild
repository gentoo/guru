# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="A Wallpaper daemon"
HOMEPAGE="https://github.com/Dotz0cat/walld"
SRC_URI="https://github.com/Dotz0cat/walld/archive/refs/tags/1.2.tar.gz -> walld-1.2.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libevent media-gfx/feh dev-libs/libconfig media-gfx/imagemagick"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}

pkg_postinst() {
	optfeature "auto reload Xresources" x11-apps/xrdb
}
