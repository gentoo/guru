# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenRC init script for QEMU/KVM"
HOMEPAGE="https://github.com/jirutka/qemu-openrc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jirutka/qemu-openrc"
else
	SRC_URI="https://github.com/jirutka/qemu-openrc/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="net-misc/socat"

PATCHES=( "${FILESDIR}/qemu-openrc-0.10.0-guest-agent.patch")

src_compile() {
	:
}

src_install() {
	newinitd qemu.initd qemu
	newconfd qemu.confd qemu
	dobin qemush
}
