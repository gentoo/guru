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
		dev-python/PyQt6[gui]
		x11-libs/libnotify
	)
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LOCALSTATEDIR="${EPREFIX}/var"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /etc/${PN}
	newins res/config/${PN}.conf.example ${PN}.conf

	newbashcomp res/completions/${PN}.bash ${PN}
	
	insinto /usr/share/zsh/site-functions
	newins res/completions/${PN}.zsh _${PN}
	
	insinto /usr/share/fish/vendor_completions.d
	doins res/completions/${PN}.fish

	if use gui; then
		domenu res/desktop/${PN}.desktop
		domenu res/desktop/${PN}-tray.desktop
	fi

	systemd_dounit res/systemd/${PN}.service
	systemd_dounit res/systemd/${PN}.timer
	use gui && systemd_dounit res/systemd/${PN}-tray.service

	newinitd res/openrc/${PN} ${PN}
}

pkg_postinst() {
	elog "Configuration file: /etc/${PN}/${PN}.conf"
	elog "See 'man ${PN}' or ${PN} --help for usage information"
	
	if use gui; then
		elog ""
		elog "GUI support is enabled. Run '${PN} --tray' for the system tray applet."
	fi
}