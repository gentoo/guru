# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Bootstrap package for dev-lang/fbc"
HOMEPAGE="https://www.freebasic.net"
SRC_URI="https://github.com/freebasic/fbc/releases/download/${PV}/FreeBASIC-${PV}-source-bootstrap.tar.xz"

S="${WORKDIR}/FreeBASIC-${PV}-source-bootstrap"

LICENSE="FDL-1.2 GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}"/fbc-1.07.0-Pass-ltinfo-to-linker.patch )

src_compile() {
	emake bootstrap-minimal \
		AR=$(tc-getAR) AS=$(tc-getAS) CC=$(tc-getCC) CFLAGS="${CFLAGS}" V=1
}

src_install() {
	newbin bin/fbc fbc-bootstrap
	emake DESTDIR="${D}" prefix="/usr/share/freebasic-bootstrap" TARGET=${CHOST} install-includes
	emake DESTDIR="${D}" prefix="/usr/share/freebasic-bootstrap" TARGET=${CHOST} install-rtlib
}
