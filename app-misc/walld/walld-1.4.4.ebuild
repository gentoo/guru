# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature meson

DESCRIPTION="A Wallpaper daemon"
HOMEPAGE="https://github.com/Dotz0cat/walld"
SRC_URI="https://github.com/Dotz0cat/walld/archive/refs/tags/1.4.4.tar.gz -> walld-1.4.4.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DEPEND="dev-libs/libevent media-gfx/feh dev-libs/libconfig media-gfx/imagemagick"
RDEPEND="${DEPEND}"

pkg_postinst() {
	optfeature "auto reload Xresources" x11-apps/xrdb
}
