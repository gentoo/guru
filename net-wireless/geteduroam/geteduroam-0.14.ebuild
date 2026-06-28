# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module desktop systemd xdg

DESCRIPTION="geteduroam Linux client" #TODO: replace with a better description, this is currently what upstream has.
HOMEPAGE="https://github.com/geteduroam/linux-app https://get.eduroam.org/"
SRC_URI="https://github.com/geteduroam/linux-app/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
# pkgcheck complains about this but this isn't from upstream
SRC_URI+=" https://codeberg.org/AshyPinguin/vendor-tarballs/releases/download/${P}/${PN}-vendor.tar.xz -> ${P}-vendor.tar.xz" # upstream doesn't bundle their vendor tarbal in their releases
S="${WORKDIR}/linux-app-${PV}"

# BSD-3 is the license of the project rest are depend.
LICENSE="MIT Apache-2.0 BSD-2 BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64" # upstream claims that it is also supported on arm64, but I've not had the ability to test this yet - AshyPinguin
IUSE="gui libnotify"

DEPEND="libnotify? ( x11-libs/libnotify )
	gui? ( >=gui-libs/gtk-4.6 >=gui-libs/libadwaita-1.1 )
	net-misc/networkmanager"
BDEPEND=">=dev-lang/go-1.25.0"
RDEPEND="${DEPEND}"

src_compile() {
	ego build -o geteduroam-cli ./cmd/geteduroam-cli
	use gui && ego build -o geteduroam-gui ./cmd/geteduroam-gui
	use libnotify && ego build -o geteduroam-notifcheck ./cmd/geteduroam-notifcheck
}

src_install() {
	dobin "${PN}-cli"

	if use gui; then
		dobin "${PN}-gui"
		newicon -s scalable "cmd/${PN}-gui/resources/images/heart.svg" "${PN}.svg"
		make_desktop_entry --eapi9 "/usr/bin/${PN}-gui" -n "${PN}" -i "${PN}" -d "${PN}"
	fi

	if use libnotify; then
		dobin "${PN}-notifcheck"
		systemd_douserunit "systemd/user/${PN}/${PN}-notifs.service"
		systemd_douserunit "systemd/user/${PN}/${PN}-notifs.timer"
	fi
}
