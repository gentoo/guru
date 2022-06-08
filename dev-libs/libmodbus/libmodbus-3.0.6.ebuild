# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Thanks to the original author for the code, xmw@gentoo.org for the code

EAPI=8

DESCRIPTION="Modbus library which supports RTU communication over a serial line or a TCP link"
HOMEPAGE="http://libmodbus.org/"
SRC_URI="http://libmodbus.org/releases/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}"
	use static-libs || rm "${D}"/usr/*/libmodbus.la
}
