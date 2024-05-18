# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Hjdskes/cage"
else
	SRC_URI="https://github.com/Hjdskes/cage/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A Wayland kiosk"
HOMEPAGE="https://www.hjdskes.nl/projects/cage/ https://github.com/Hjdskes/cage"
LICENSE="MIT"
SLOT="0"

IUSE="X"

RDEPEND="
	gui-libs/wlroots:0/17[X?]
	x11-libs/libxkbcommon[X?]
"
DEPEND="${RDEPEND}"

src_configure() {
	meson_src_configure $(meson_feature X xwayland)
}
