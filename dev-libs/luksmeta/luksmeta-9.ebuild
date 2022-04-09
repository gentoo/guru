# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="LUKSMeta is a simple library for storing metadata in the LUKSv1 header"
HOMEPAGE="https://github.com/latchset/luksmeta"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-fs/cryptsetup"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-tests.patch"
)

src_prepare() {
	default
	eautoreconf
}
