# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info

DESCRIPTION="A static multicast routing daemon"
HOMEPAGE="https://troglobit.com/projects/smcroute/"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE="caps systemd"

BDEPEND="
	virtual/pkgconfig
"
RDEPEND="
	caps? ( sys-libs/libcap )
	systemd? ( sys-apps/systemd:0= )
"
DEPEND="
	${RDEPEND}
"

CONFIG_CHECK="
	~CONFIG_IP_MROUTE
	~CONFIG_IP_PIMSM_V1
	~CONFIG_IP_PIMSM_V2
	~CONFIG_IP_MROUTE_MULTIPLE_TABLES
	~CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
"

src_configure() {
	local myconf=(
		$(use_with caps libcap)
		$(use_with systemd)
	)
	econf "${myconf[@]}"
}
