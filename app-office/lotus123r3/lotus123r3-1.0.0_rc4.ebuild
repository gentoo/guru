# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_r/r}"

DESCRIPTION="A native port of Lotus 1-2-3 to Linux."

HOMEPAGE="https://123r3.net/"

SRC_URI="
	https://github.com/taviso/123elf/archive/refs/tags/v${MY_PV}.tar.gz
	https://archive.org/download/123-unix/123UNIX1.IMG
	https://archive.org/download/123-unix/123UNIX2.IMG
	https://archive.org/download/123-unix/123UNIX3.IMG
	https://archive.org/download/123-unix/123UNIX4.IMG
	https://archive.org/download/123-unix/123UNIX5.IMG
"

S="${WORKDIR}/123elf-${MY_PV}"

# It's abandonware, see: https://github.com/taviso/123elf/issues/105
LICENSE="all-rights-reserved"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+abi_x86_32"

RESTRICT="bindist mirror"

DEPEND="sys-libs/ncurses-compat:5"
RDEPEND="${DEPEND}"

BDEPEND="
	app-alternatives/gzip[reference]
	sys-devel/binutils[multitarget]
"
QA_PREBUILT="usr/bin/123"

src_prepare() {
	default

	cp "${DISTDIR}"/123UNIX*.IMG "${S}"/

	./extract.sh

	# Fix the Makefile
	sed -i 's|prefix = /usr/local|prefix = $(DESTDIR)/usr|g' Makefile
}
