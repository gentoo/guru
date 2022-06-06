# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="UDT is a UDP based data transport protocol"
HOMEPAGE="http://udt.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}.sdk.${PV}.tar.gz"
S="${WORKDIR}/${PN}4"

LICENSE="BSD"
SLOT="4"
KEYWORDS="~amd64"

DOCS=( README.txt RELEASE_NOTES.txt draft-gg-udt-xx.txt )
PATCHES=( "${FILESDIR}/${P}-makefiles.patch" )

src_compile(){
	tc-export CXX

	# IA32 isn't a typo
	case ${ARCH} in
		x86)        PLATFORM="IA32";;
		ppc|ppc64)  PLATFORM="POWERPC";;
		amd64)      PLATFORM="AMD64";;
		ia64)       PLATFORM="IA64";;
	esac

	case ${CHOST} in
		*-freebsd*|*-netbsd*|*-openbsd*|*-dragonfly*)  OSNAME="BSD" ;;
		*-darwin*)                                     OSNAME="OSX" ;;
		*)                                             OSNAME="LINUX" ;;
	esac

	MAKEOPTS="-j1" emake os="${OSNAME}" arch="${PLATFORM}"
}

src_install(){
	dolib.so src/libudt.so
	dosym ./libudt.so /usr/$(get_libdir)/libudt.so.0
	exeinto "/usr/libexec/udt"
	doexe app/{appserver,appclient,sendfile,recvfile}

	insinto /usr/include/udt
	doins src/udt.h

	local HTML_DOCS=( doc/* )
	einstalldocs

	cat  <<EOF > udt.pc
prefix=/usr
libdir=\${prefix}/$(get_libdir)
includedir=\${prefix}/include

Name: ${PN}
Description: ${DESCRIPTION}
Version: ${PV}
URL: ${HOMEPAGE}
Libs: -L\${libdir} -ludt
Cflags: -I\${includedir}/udt
EOF

	insinto "/usr/$(get_libdir)/pkgconfig"
	doins udt.pc
}
