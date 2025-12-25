# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit cmake

DESCRIPTION="An update notifier & applier for Gentoo Linux that assists with pre/post update tasks"
HOMEPAGE="https://github.com/Techoraye/gentoo-update"
SRC_URI="https://github.com/Techoraye/gentoo-update/archive/v${PV}.tar.gz"

S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="notification python"

DEPEND="
	>=dev-cpp/cpp-base:0
"

RDEPEND="${DEPEND}
	notification? ( x11-libs/libnotify )
	python? ( 
		dev-python/pyqt6[gui]
	)
	app-portage/gentoolkit
	sys-apps/portage[python]
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LOCALSTATEDIR="${EPREFIX}/var"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	
	# Install documentation
	einstalldocs
	
	# Install configuration example
	insinto /etc/gentoo-update
	newins res/config/gentoo-update.conf.example gentoo-update.conf
	
	# Install shell completions
	insinto /usr/share/bash-completion/completions
	doins res/completions/gentoo-update.bash
	
	insinto /usr/share/zsh/site-functions
	newins res/completions/gentoo-update.zsh _gentoo-update
	
	insinto /usr/share/fish/vendor_completions.d
	doins res/completions/gentoo-update.fish
	
	# Install desktop entry files
	insinto /usr/share/applications
	doins res/desktop/gentoo-update.desktop
	doins res/desktop/gentoo-update-tray.desktop
	
	# Install systemd units
	insinto /etc/systemd/system
	doins res/systemd/gentoo-update.service
	doins res/systemd/gentoo-update.timer
	doins res/systemd/gentoo-update-tray.service
	
	# Install OpenRC service
	insinto /etc/init.d
	newins res/openrc/gentoo-update gentoo-update
}

pkg_postinst() {
	elog "Gentoo-Update has been installed successfully!"
	elog ""
	elog "Usage: gentoo-update [OPTIONS]"
	elog ""
	elog "For help: gentoo-update --help"
	elog ""
	elog "Configuration file: ~/.config/gentoo-update/gentoo-update.conf"
	elog "Generate default config: gentoo-update --gen-config"
	elog ""
	
	if use python; then
		elog "Python support enabled. You can use the system tray applet:"
		elog "  gentoo-update --tray"
	fi
	
	if use notification; then
		elog "Desktop notifications enabled."
	fi
}
