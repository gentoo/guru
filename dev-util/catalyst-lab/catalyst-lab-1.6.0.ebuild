# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An automation tool for building Gentoo release stages and binhost packages."
HOMEPAGE="https://github.com/damiandudycz/catalyst-lab"
SRC_URI="https://github.com/damiandudycz/catalyst-lab/archive/refs/tags/catalyst-lab-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-${PN}-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="qemu git binhost"

RDEPEND="
	dev-util/catalyst
	app-misc/yq
	binhost? ( sys-fs/squashfs-tools )
	qemu? ( app-emulation/qemu[static-user] )
	git? ( dev-vcs/git dev-vcs/git-lfs )
"
BDEPEND="app-arch/unzip"

src_install() {
	# Install catalyst-lab
	dodir /usr/bin
	dobin "${S}/${PN}"

	# Create the config file
	insinto /etc/catalyst-lab
	doins "${S}/${PN}.conf"
}
