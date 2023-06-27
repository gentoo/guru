# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake autotools

DESCRIPTION="IP2Location C Library"
HOMEPAGE="https://github.com/chrislim2888/IP2Location-C-Library/"
SRC_URI="https://github.com/chrislim2888/IP2Location-C-Library/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

src_unpack() {
	unpack ${A}
	mv IP2Location-C-Library-${PV} ip2loc-${PV}
}

src_prepare() {
	eautoreconf

	eapply_user
}

src_configure() {
	./configure --prefix=${T}/usr
}

src_compile() {
	make
}

src_install() {
	make install
}

pkg_preinst() {
	mkdir -p ${D}/usr/lib/
	mkdir -p ${D}/usr/include/
	cp -a ${T}/usr/include/IP2Location.h ${D}/usr/include/
	cp -a ${T}/usr/lib/libIP2Location* ${D}/usr/lib/
	return
}
