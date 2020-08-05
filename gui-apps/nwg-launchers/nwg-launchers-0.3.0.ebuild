# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/nwg-piotr/${PN}"
case "${PV}" in
	9999)
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
esac
inherit meson

DESCRIPTION="GTK+ launchers for sway, i3 and some other WMs"
HOMEPAGE="${EGIT_REPO_URI}"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/gtk+:3
	dev-cpp/gtkmm:3.0
	dev-cpp/nlohmann_json"
DEPEND="${RDEPEND}"

IUSE="+bar +dmenu +grid"

src_configure() {
	meson_src_configure $(meson_use bar) $(meson_use dmenu) $(meson_use grid)
}
