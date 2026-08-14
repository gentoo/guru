# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="C library for the Storj V3 network (libuplink)"
HOMEPAGE="https://www.storj.io/ https://github.com/storj/uplink-c"
MY_PN="uplink-c"

SRC_URI="
https://github.com/storj/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://codeberg.org/davidreed/uplink-c/releases/download/v${PV}/${MY_PN}-${PV}-vendor.tar.xz
"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="static-libs"

RESTRICT="test"

BDEPEND="
	>=dev-lang/go-1.25.0:=
	app-arch/unzip
	virtual/pkgconfig
"

src_prepare() {
	default

	# remove upstream's pre-stripped flags and add SONAME
	sed -i \
		-e 's/LDFLAGS="-s -w"/LDFLAGS="-extldflags=-Wl,-soname,libuplink.so"/' \
		scripts/build-lib || die
}

src_compile() {
	emake build
}

src_install() {
	# Shared libs
	dolib.so .build/libuplink.so

	# Optional static libs
	if use static-libs ; then
	dolib.a  .build/libuplink.a
	fi

	# Headers (upstream copies them into .build/uplink)
	insinto /usr/include/uplink
	doins .build/uplink/*.h

	# pkg-config file
	insinto /usr/$(get_libdir)/pkgconfig
	doins .build/libuplink.pc
}
