# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-launchers.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-launchers/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
inherit meson

DESCRIPTION="GTK+ launchers for sway, i3 and some other WMs"
HOMEPAGE="https://github.com/nwg-piotr/nwg-launchers"
LICENSE="GPL-3"

SLOT="0"

RDEPEND="
	x11-libs/gtk+:3
	dev-cpp/gtkmm:3.0
	dev-cpp/nlohmann_json"
DEPEND="${RDEPEND}"

IUSE="+bar +dmenu +grid"

RESTRICT="mirror"

src_configure() {
	meson_src_configure $(meson_use bar) $(meson_use dmenu) $(meson_use grid)
}
