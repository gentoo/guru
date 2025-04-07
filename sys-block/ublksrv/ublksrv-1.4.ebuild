# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Userspace block device driver"
HOMEPAGE="https://github.com/ublk-org/ublksrv"
SRC_URI="https://github.com/ublk-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnutls"

DEPEND="
	gnutls? ( net-libs/gnutls )
	sys-libs/liburing
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_with gnutls)
	)

	econf "${myeconfargs}"
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}
