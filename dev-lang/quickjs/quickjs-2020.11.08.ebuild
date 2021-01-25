# Copyright 2021 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN}-${PV//./-}"

DESCRIPTION="Small embeddable Javascript engine"
HOMEPAGE="https://bellard.org/quickjs/"
SRC_URI="https://bellard.org/quickjs/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	sed -i \
		-e 's;prefix=/usr/local;prefix=/usr;' \
		-e '/$(STRIP) .*/d' \
		Makefile || die "Failed setting prefix"

	default
}
