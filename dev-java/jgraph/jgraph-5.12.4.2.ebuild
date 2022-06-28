# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"
MYPN="lib${PN}-java"
MYPV="${PV}+dfsg.orig"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Open-source graph component for Java"
SRC_URI="mirror://debian/pool/main/libj/${MYPN}/${MYPN}_${MYPV}.tar.gz"
HOMEPAGE="https://www.jgraph.com"
S="${WORKDIR}/${MYPN}-${MYPV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples source"

DEPEND=">=virtual/jdk-1.8:*"
RDEPEND=">=virtual/jre-1.8:*"

DOCS=( README WHATSNEW LICENSE ChangeLog )

JAVA_SRC_DIR="src"

src_prepare() {
	default
	einstalldocs
	java-pkg_clean
}
