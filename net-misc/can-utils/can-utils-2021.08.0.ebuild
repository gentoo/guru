# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools systemd

DESCRIPTION="SocketCAN userspace utilities and tools"
HOMEPAGE="https://github.com/linux-can/can-utils"
SRC_URI="https://github.com/linux-can/can-utils/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default

	eautoreconf
}

# Default src_install + newconfd and newinitd
src_install() {

	emake DESTDIR="${D}" install

	einstalldocs

	systemd_dounit "${FILESDIR}/slcan.service"
	systemd_install_serviced "${FILESDIR}/slcan.service.conf"
	newconfd "${FILESDIR}/slcand.confd" slcand
	newinitd "${FILESDIR}/slcand.initd" slcand
}
