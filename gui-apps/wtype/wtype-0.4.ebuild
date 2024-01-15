# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="xdotool type for wayland"
HOMEPAGE="https://github.com/atx/wtype"
SRC_URI="https://github.com/atx/wtype/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/wayland
	x11-libs/libxkbcommon"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/cmake"

src_configure() {
	meson_src_configure
}
