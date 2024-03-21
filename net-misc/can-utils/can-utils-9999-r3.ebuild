# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/linux-can/${PN}.git"
EGIT_BRANCH="master"

inherit autotools git-r3 systemd

DESCRIPTION="CAN userspace utilities and tools"
HOMEPAGE="https://github.com/linux-can/"

LICENSE="GPL-2"
SLOT="0"

src_prepare() {
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
