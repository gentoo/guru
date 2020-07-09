# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd udev golang-build golang-vcs-snapshot

EGO_PN="github.com/trezor/trezord-go"
ARCHIVE_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="TREZOR Communication Daemon"
HOMEPAGE="https://github.com/trezor/trezord-go"
SRC_URI="${ARCHIVE_URI}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd +udev"
RESTRICT="test"

DEPEND="
	acct-user/trezord
	acct-group/plugdev"

src_install() {
	newbin trezord-go trezord
	newinitd "${FILESDIR}/trezord-openrc.sh" trezord
	keepdir /var/log/trezord
	fowners trezord:root /var/log/trezord

	use systemd && systemd_dounit src/github.com/trezor/trezord-go/release/linux/trezord.service
	use udev && udev_dorules src/github.com/trezor/trezord-go/release/linux/trezor.rules
}
