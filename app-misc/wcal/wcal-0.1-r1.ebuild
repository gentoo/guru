# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ISO weekly calendar"
HOMEPAGE="https://github.com/leahneukirchen/wcal"
SRC_URI="https://github.com/leahneukirchen/wcal/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="CC0-1.0"
SLOT="0"

# check target in Makefile but no test cases
RESTRICT="test"

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
