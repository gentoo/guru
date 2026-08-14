# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="SocketCAN userspace utilities and tools"
HOMEPAGE="https://github.com/linux-can/can-utils"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linux-can/can-utils.git"
else
	SRC_URI="https://github.com/linux-can/can-utils/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

PATCHES=(
	"${FILESDIR}/${P}-cmake-set-policy.patch"
)

src_install() {
	cmake_src_install

	systemd_dounit "${FILESDIR}/slcan.service"
	systemd_install_serviced "${FILESDIR}/slcan.service.conf"
	newconfd "${FILESDIR}/slcand.confd" slcand
	newinitd "${FILESDIR}/slcand.initd" slcand
}
