# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop fcaps wrapper xdg udev

DESCRIPTION="All-in-one stability, stress test, benchmark and monitoring tool"
HOMEPAGE="https://www.ocbase.com"

SRC_URI="https://www.ocbase.com/download/edition:Personal/os:Linux/version:${PV} -> ${P}.bin"
S="${WORKDIR}"

LICENSE="OCBASE-EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="msr-user-access"
RESTRICT="bindist mirror strip"

src_unpack() {
	cp "${DISTDIR}"/"${P}".bin ./
}

src_install() {
	newicon -s 256 "${FILESDIR}"/occt.png occt.png

	insinto /opt/occt

	newins "${P}".bin occt

	# Disable automatic updates
	touch "${ED}"/opt/occt/disable_update

	# Don't use binary path as the config location
	touch "${ED}"/opt/occt/use_home_config

	fperms +x /opt/occt/occt

	domenu "${FILESDIR}"/occt.desktop

	make_wrapper occt /opt/occt/occt

	use msr-user-access && udev_dorules "${FILESDIR}/90-occt-msr-access.rules"
}

pkg_postinst() {
	# Allow benchmarks to run with higher priority
	fcaps cap_sys_nice opt/occt/occt

	# Allow /dev/cpu/*/msr access
	fcaps cap_sys_rawio opt/occt/occt

	# Apply the udev rules
	use msr-user-access && udev_reload && udevadm trigger --action=add --subsystem-match=msr

	einfo ""
	einfo "If you have a license, you need to copy it into the OCCT config directory:"
	einfo ""
	einfo "  mkdir -p ~/.config/occt && cp license.okl ~/.config/occt/"
	einfo ""
}
