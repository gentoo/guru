# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake gnome2-utils

DESCRIPTION="GTK-plugin for global menu on Plasma Wayland"
HOMEPAGE="https://github.com/guiodic/appmenu-gtk-module-wayland"
SRC_URI="https://github.com/guiodic/appmenu-gtk-module-wayland/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu[gtk3]
	dev-libs/wayland
	x11-libs/gtk+:3[wayland]
	x11-libs/libX11
	systemd? (
		sys-apps/dbus
		sys-apps/systemd
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/glib:2
	virtual/pkgconfig
"

src_install() {
	cmake_src_install

	if ! use systemd; then
		rm -rf "${ED}/usr/lib/systemd" || die
	fi
}

pkg_postinst() {
	gnome2_schemas_update

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Session script installed to /etc/profile.d/${PN}.sh (log out and back in)."
		elog "For TTY Wayland launches, source /etc/profile.d/${PN}.sh in your compositor startup."
		if use systemd; then
			elog "For systemd user sessions, enable the service:"
			elog "  systemctl --user enable --now ${PN}.service"
		fi
	fi
}

pkg_postrm() {
	gnome2_schemas_update
}
