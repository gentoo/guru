# Copyright 2024-2026 TRCC Linux Contributors
# Distributed under the terms of the GNU General Public License v3+

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 udev systemd

DESCRIPTION="Thermalright LCD/LED Control Center for Linux"
HOMEPAGE="https://github.com/Lexonight1/thermalright-trcc-linux"
SRC_URI="https://github.com/Lexonight1/thermalright-trcc-linux/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/thermalright-trcc-linux-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nvidia wayland hid"

RDEPEND="
	dev-python/pyside6[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/typer[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
	dev-libs/libusb:1
	sys-apps/sg3_utils
	app-arch/p7zip
	nvidia? ( dev-python/pynvml[${PYTHON_USEDEP}] )
	wayland? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	)
	hid? ( dev-python/hidapi[${PYTHON_USEDEP}] )
"
BDEPEND="
	dev-python/hatchling[${PYTHON_USEDEP}]
"

src_install() {
	distutils-r1_src_install

	# udev rules
	udev_dorules packaging/udev/99-trcc-lcd.rules

	# modprobe config
	insinto /etc/modprobe.d
	doins packaging/modprobe/trcc-lcd.conf

	# modules-load
	insinto /etc/modules-load.d
	doins packaging/modprobe/trcc-sg.conf

	# desktop entry
	insinto /usr/share/applications
	doins src/trcc/assets/trcc-linux.desktop

	# polkit policy
	insinto /usr/share/polkit-1/actions
	doins src/trcc/assets/com.github.lexonight1.trcc.policy

	# systemd service
	systemd_dounit src/trcc/assets/trcc-quirk-fix.service
}

pkg_postinst() {
	udev_reload

	elog "Thermalright TRCC Linux has been installed."
	elog ""
	elog "To get started:"
	elog "  1. Unplug and replug the USB cable (or reboot)"
	elog "  2. Run: trcc detect --all"
	elog "  3. Run: trcc gui"
	elog ""
	elog "If your device is not detected, ensure the sg kernel module is loaded:"
	elog "  modprobe sg"
	elog ""
	elog "For NVIDIA GPU sensor support, enable the nvidia USE flag."
}

pkg_postrm() {
	udev_reload
}
