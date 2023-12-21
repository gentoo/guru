# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop udev

MY_PN=OpenTabletDriver

DESCRIPTION="Cross platform tablet driver (binary package)"
HOMEPAGE="https://github.com/OpenTabletDriver"
#SRC_URI="https://github.com/OpenTabletDriver/OpenTabletDriver/archive/refs/tags/v${PV}.tar.gz -> OpenTabletDriver-source-${PV}.tar.gz https://github.com/OpenTabletDriver/OpenTabletDriver/releases/download/v${PV}/OpenTabletDriver.linux-x64.tar.gz -> OpenTabletDriver-v${PV}.tar.gz"
SRC_URI="https://github.com/OpenTabletDriver/OpenTabletDriver/releases/download/v${PV}/opentabletdriver-${PV}-x64.tar.gz -> OpenTabletDriver-v${PV}.tar.gz"
S="${WORKDIR}/opentabletdriver"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

DEPEND="
	x11-libs/libX11
	x11-libs/libXrandr
	dev-libs/libevdev
	x11-libs/gtk+:3
	virtual/udev
	virtual/libudev
	dev-dotnet/dotnet-sdk-bin:6.0
"

QA_PREBUILT="*"

src_install() {
	local LP=opentabletdriver
	local SP="otd"

	cd "${S}/usr/local/lib/${LP}" || die

	exeinto "/usr/lib/${LP}"
	exeopts -o root -Dm755

	for bin in *.Daemon *.UX.Gtk *.Console; do
		doexe "$bin"
	done

	#insinto "/usr/lib/${LP}"

	#for bin in *.Daemon *.UX.Gtk *.Console; do
	#	doins "$bin"
	#done

	cd "${FILESDIR}" || die

	exeinto "/usr/bin"
	exeopts -o root -Dm755

	for binary in otd*; do
		doexe "$binary"
	done

	cd "${S}/usr/local/share" || die

	insinto "/usr/share"
	doins -r "applications"
	dodoc -r "doc"
	doman "${FILESDIR}/opentabletdriver.8"
	doins -r "pixmaps"
	doicon "pixmaps/otd.png"

	cd "${S}/etc/udev/rules.d" || die

	insinto "/lib/udev/rules.d"
	doins -r "70-opentabletdriver.rules"

	make_desktop_entry /usr/local/bin/otd-gui OpenTabletDriver otd Settings
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
	udevadm control --reload || die
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Please replug your tablet before attempting to use the driver"
	fi
}
