# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd udev

DESCRIPTION="TREZOR Communication Daemon"
HOMEPAGE="https://github.com/trezor/trezord-go"
if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/trezor/trezord-go"
	inherit git-r3
else
	SRC_URI="
		https://github.com/trezor/trezord-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}
	"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="systemd +udev"
RESTRICT="mirror test"

DEPEND="
	acct-user/trezord
	acct-group/plugdev
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	fi
	go-module_src_unpack
}

src_compile() {
	default
}

src_install() {
	newbin trezord-go trezord
	newinitd "${FILESDIR}/trezord-openrc.sh" trezord
	keepdir /var/log/trezord
	fowners trezord:root /var/log/trezord
	einstalldocs

	use systemd && systemd_dounit release/linux/trezord.service
	use udev && udev_dorules release/linux/trezor.rules
}

pkg_postinst() {
	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}
