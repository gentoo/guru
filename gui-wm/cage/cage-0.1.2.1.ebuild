# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/Hjdskes/${PN}"
case "${PV}" in
	9999)
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
esac
inherit meson

DESCRIPTION="A Wayland kiosk"
HOMEPAGE="https://www.hjdskes.nl/projects/${PN}"
LICENSE="MIT"
SLOT="0"

IUSE="-X"

RDEPEND="
	>=gui-libs/wlroots-0.11
	x11-libs/libxkbcommon
	X? (
		gui-libs/wlroots[X]
		x11-libs/libxkbcommon[X]
	)
"
DEPEND="${RDEPEND}"

KEYWORDS="-amd64 -x86"

src_configure() {
	meson_src_configure $(meson_use X xwayland)
}
