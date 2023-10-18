# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-launchers.git"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-launchers/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
inherit meson xdg

DESCRIPTION="GTK+ launchers for sway, i3 and some other WMs"
HOMEPAGE="https://github.com/nwg-piotr/nwg-launchers"
LICENSE="GPL-3 CC-BY-SA-3.0"

SLOT="0"

RDEPEND="
	x11-libs/gtk+:3
	dev-cpp/gtkmm:3.0
	dev-cpp/nlohmann_json
	layershell? ( gui-libs/gtk-layer-shell )
	dev-cpp/atkmm
	dev-cpp/cairomm
	dev-cpp/glibmm:2
	dev-libs/glib:2
	dev-libs/libsigc++:2
"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

IUSE="+bar +dmenu +grid layershell"

src_configure() {
	meson_src_configure $(meson_use bar) $(meson_use dmenu) $(meson_use grid) $(meson_feature layershell layer-shell)
}

src_install() {
	meson_src_install

	insinto /usr/share/icons/nwg-launchers
	doins -r "${FILESDIR}"/.
}
