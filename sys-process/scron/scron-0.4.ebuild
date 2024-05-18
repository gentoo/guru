# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Simple cron daemon"
HOMEPAGE="https://git.2f30.org/scron/"
SRC_URI="https://dl.2f30.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!sys-process/cronie
	!sys-process/bcron
	!sys-process/dcron
	!sys-process/fcron
	!sys-process/systemd-cron
"

src_install() {
	emake MANPREFIX="/usr/share/man" PREFIX="/usr" DESTDIR="${D}" install
	einstalldocs
	newinitd "${FILESDIR}/${PN}-0.4-initd" ${PN}
}

pkg_postinst() {
	elog "Start scron as a system service with"
	elog "'rc-service scron start'. Enable it at startup with"
	elog "'rc-update add scron default'."
}
