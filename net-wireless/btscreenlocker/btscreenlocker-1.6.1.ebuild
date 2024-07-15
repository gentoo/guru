# Copyright 2024 Brayan M. Salazar <this.brayan@proton.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon to lock your screen when Bluetooth trusted devices go away."
HOMEPAGE="https://github.com/brookiestein/BtScreenLocker"
SRC_URI="https://github.com/brookiestein/BtScreenLocker/archive/refs/tags/${PV}.tar.gz -> BtScreenLocker-${PV}.tar.gz"
S="${WORKDIR}/BtScreenLocker-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
dev-qt/qtbluetooth:5
dev-qt/qtdbus:5
dev-qt/qtwidgets:5
dev-qt/linguist-tools:5
>=net-wireless/bluez-5.76
"
RDEPEND="${DEPEND}"
BDEPEND="
sys-apps/coreutils
>=dev-build/cmake-3.28
"

src_configure() {
	cmake_src_configure || die "Couldn't configure ${PN}."
}

src_compile() {
	cmake_build || die "Couldn't compile ${PN}."
}

src_install() {
	cmake_src_install || die "Couldn't install ${PN}."
}
