# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="C library for the Storj V3 network (libuplink)"
HOMEPAGE="https://storj.io https://github.com/storj/uplink-c"
MY_PN="uplink-c"

SRC_URI="
https://github.com/storj/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/david-gentoo/uplink-c/releases/download/v${PVR}/${MY_PN}-${PVR}-vendor.tar.xz
"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="static-libs"

BDEPEND="
	>=dev-lang/go-1.20:=
	app-arch/unzip
	virtual/pkgconfig
"

src_compile() {
	emake build
}

src_install() {
	# Shared libs
	dolib.so .build/libuplink.so || die "failed to install libuplink.so"

	# Optional static libs
	if use static-libs ; then
	dolib.a  .build/libuplink.a  || die "failed to install libuplink.a"
	fi

	# Headers (upstream copies them into .build/uplink)
	insinto /usr/include/uplink
	doins .build/uplink/*.h || die "failed to install headers"

	# pkg-config file
	insinto /usr/$(get_libdir)/pkgconfig
	doins .build/libuplink.pc || die "failed to install libuplink.pc"
}
