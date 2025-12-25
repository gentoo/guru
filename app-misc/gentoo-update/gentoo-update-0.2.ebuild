# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="Update notifier and applier for Gentoo Linux"
HOMEPAGE="https://github.com/Techoraye/gentoo-update"
SRC_URI="https://github.com/Techoraye/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="gui"

RDEPEND="
	app-portage/gentoolkit
	sys-apps/portage
	gui? (
		dev-python/pyqt6
		x11-libs/libnotify
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_GUI=$(usex gui)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	elog "Configuration example:"
	elog "  /usr/share/${PN}/config/${PN}.conf.example"
	elog "Copy it to /etc/${PN}/${PN}.conf and adjust as needed."

	if use gui; then
		elog "Run '${PN} --tray' to start the system tray applet."
	fi

	if systemd_is_booted; then
		elog "Enable automatic updates:"
		elog "  systemctl enable --now ${PN}.timer"
	else
		elog "Enable automatic updates:"
		elog "  rc-update add ${PN} default"
	fi
}
