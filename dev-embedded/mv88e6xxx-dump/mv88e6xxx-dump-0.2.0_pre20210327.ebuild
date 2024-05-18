# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_COMMIT="25fa4d07d7a5551fee6d8d7ad128cdffd50532c8"

DESCRIPTION="Dump information about Marvell mv88e6xxx Ethernet switches"
HOMEPAGE="https://github.com/lunn/mv88e6xxx_dump"
SRC_URI="https://github.com/lunn/mv88e6xxx_dump/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/mv88e6xxx_dump-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

BDEPEND="virtual/pkgconfig"
DEPEND="net-libs/libmnl:="

src_prepare() {
	default
	eautoreconf
}
