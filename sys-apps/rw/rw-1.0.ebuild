# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="A dd replacement from the Sortix operating system"
HOMEPAGE="https://sortix.org/rw/"
SRC_URI="https://sortix.org/rw/release/${PN}-portable-${PV}.tar.gz"

MY_P="${PN}-portable-${PV}"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}
