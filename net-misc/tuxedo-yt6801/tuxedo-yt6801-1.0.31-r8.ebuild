# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Motorcomm YT6801 Ethernet driver for TUXEDO Computers"
HOMEPAGE="https://gitlab.com/tuxedocomputers/development/packages/tuxedo-yt6801"
SRC_PV="v${PV}-8"
SRC_URI="
		https://en.motor-comm.com/En/Skippower/downloadFile.html?id=607 -> yt6801-linux-driver-${PV}.zip
		https://gitlab.com/tuxedocomputers/development/packages/tuxedo-yt6801/-/archive/${SRC_PV}/tuxedo-yt6801-${SRC_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/linux-sources"
DEPEND="${RDEPEND}"

inherit linux-mod-r1

src_unpack() {
	unpack tuxedo-yt6801-${SRC_PV}.tar.gz || die
	mkdir yt6801-driver || die
	cd yt6801-driver || die
	unpack yt6801-linux-driver-${PV}.zip || die
	unpack ./yt6801-${PV}.tar.gz || die
	cd .. || die
	mv "${WORKDIR}/tuxedo-yt6801-${SRC_PV}" "${WORKDIR}/${P}" || die
	cp "${WORKDIR}/yt6801-driver/Makefile" "${WORKDIR}/${P}/src/" || die
	S="${WORKDIR}/${P}"
}

src_compile() {
	cd "${S}/src" || die

	local modlist=( yt6801=net/ethernet/motorcomm:${S}/src )
	local modargs=( KSRC=${KERNEL_DIR} KCFLAGS=-DFXGMAC_INT_MODERATION_ENABLED=1 )

	linux-mod-r1_src_compile
}

src_install() {
	cd "${S}/src" || die

	linux-mod-r1_src_install
}
