# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# This date info can be find in the download page of the driver
# You can use any tablet page since the driver is the same to all
M_PV=3.4.9
P_YEAR=24
P_MONTH=06
P_DAY=07

R_YEAR=24
R_MONTH=07

inherit desktop linux-info udev xdg
M_P="XPPenLinux${M_PV}-${P_YEAR}${P_MONTH}${P_DAY}"

DESCRIPTION="Driver for XP-PEN tablets and drawing devices"
HOMEPAGE="https://www.xp-pen.com"
SRC_URI="https://download01.xp-pen.com/file/20${R_YEAR}/${R_MONTH}/${M_P}.tar.gz -> ${M_P}.tar.gz"

S="${WORKDIR}/${M_P}"

LICENSE="HANVON-UGEE-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5[X]
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5[X]
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	dev-libs/icu
	dev-libs/libusb
	x11-libs/libxcb
	virtual/libudev:="
DEPEND="${RDEPEND}"

QA_PREBUILT=".*"

pkg_pretend() {
	linux-info_pkg_setup

	if ! linux_config_exists \
			|| (! linux_chkconfig_present CONFIG_INPUT \
			&& ! linux_chkconfig_present CONFIG_INPUT_UINPUT); then
		echo
		ewarn "If you use a USB XP-PEN tablet, you need to enable support in your kernel"
		ewarn "  Device Drivers --->"
		ewarn "    Input device support  --->"
		ewarn "      [*] Generic input layer (needed for keyboard, mouse,...)"
		ewarn "      [*]   Miscellaneous devices --->"
		ewarn "         <*>   User level driver support"
		echo
	fi
}

src_install() {
	# Config.xml location is hardcoded
	local app_root=/usr/lib/pentablet
	local app_dest="${ED}"/${app_root}

	# Remove pre-compiled libaries (use system ones)
	# Might be reverted if system ones dont work
	rm -r "${S}/App/usr/lib/pentablet/lib" "${S}/App/usr/lib/pentablet/platforms" || die
	rm "${S}/App/usr/lib/pentablet/PenTablet.sh" || die

	# Install Application folder
	dodir "${app_root%/*}"
	cp -r  "${S}/App/usr/lib/pentablet/" "${app_dest}" || die

	# Install udev rule
	udev_dorules "${S}/App/lib/udev/rules.d/10-xp-pen.rules"

	# Install Icon and Desktop file
	doicon --size 256 "${S}/App/usr/share/icons/hicolor/256x256/apps/xppentablet.png"
	#domenu "${S}/App/usr/share/applications/xppentablet.desktop"
	domenu "${FILESDIR}/xppentablet.desktop"
}

pkg_postinst() {
	ewarn "XP-PEN Pen Driver Application still dosen't support Wayland"
	ewarn "The desktop file included force the app to run in X11/XWayland"
	ewarn "At least, the application completed works when using XWayland"
	ewarn "The only little problem is the screen becames black"
	ewarn "when selecting the screen area using the option: 'Customize screen Area'"
	udev_reload
	xdg_pkg_postinst
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}
