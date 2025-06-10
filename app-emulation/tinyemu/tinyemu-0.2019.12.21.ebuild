# Copyright 2022 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-$(ver_rs 1- - "$(ver_cut 2-)")"

DESCRIPTION="small and simple system emulator for the RISC-V and x86 architectures"
HOMEPAGE="https://bellard.org/tinyemu/"
SRC_URI="https://bellard.org/tinyemu/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="http +sdl"

DEPEND="
	http? (
		net-misc/curl
		dev-libs/openssl:=
	)
	sdl? ( media-libs/libsdl )
"
RDEPEND="${DEPEND}"

DOCS=( readme.txt )

src_prepare() {
	default

	sed -i \
		-e 's;^bindir=.*;bindir=/usr/bin/;' \
		-e 's;^CC=.*;CC ?= cc;' \
		-e 's;^STRIP=.*;STRIP=true;' \
		-e 's;^CFLAGS=-O2 -Wall -g;CFLAGS+=;' \
		Makefile || die
}

src_configure() {
	if use !http; then sed -i '/^CONFIG_FS_NET/s;^;#;' Makefile || die; fi
	if use !sdl; then sed -i '/^CONFIG_SDL/s;^;#;' Makefile || die; fi
}

src_install() {
	mkdir -p "${ED}/usr/bin/" || die
	default
}
