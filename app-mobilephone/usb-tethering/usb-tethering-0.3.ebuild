# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="USB tethering on Pine64/ConfigFS systems"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch"

S="${WORKDIR}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~arm64"

DEPEND="
	net-misc/dhcp
	sys-apps/systemd
"
RDEPEND="${DEPEND}"

src_install() {
	exeinto "/usr/lib/danctnix"
	doexe "${FILESDIR}/usb-tethering"
	systemd_dounit "${FILESDIR}"/usb-tethering.service
	insinto "/usr/lib/tmpfiles.d/"
	doins "${FILESDIR}"/tmpfiles.d.danctnix-usb.conf
	insinto "/etc/systemd/system/dhcpd4.service.d/"
	doins "${FILESDIR}"/dhcpd4.service-customexec.conf
	insinto "/etc/danctnix/"
	doins "${FILESDIR}"/dhcpd.conf
}
