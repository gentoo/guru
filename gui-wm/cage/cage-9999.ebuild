# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
HOMEPAGE="https://www.hjdskes.nl/projects/cage https://github.com/Hjdskes/cage"
LICENSE="MIT"
SLOT="0"

IUSE="X"

RDEPEND="
	>=gui-libs/wlroots-0.13
	x11-libs/libxkbcommon
	X? (
		gui-libs/wlroots[X]
		x11-libs/libxkbcommon[X]
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	meson_src_configure $(meson_use X xwayland)
}
