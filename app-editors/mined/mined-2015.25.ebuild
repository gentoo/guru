# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=7
inherit toolchain-funcs

DESCRIPTION="A powerful text editor with extensive Unicode and CJK support"
HOMEPAGE="http://towo.net/mined/"
SRC_URI="https://downloads.sourceforge.net/project/mined/mined/mined%20${PV}/${P}.tar.gz?ts=gAAAAABhfF-EKWvxGfwH7tpfR0NI8LV87Muimvh4jUigxZZZAD1fN8xgcbBPJc1TQ3f8djMFDbHXXz6rQZI4_qwwEsqakvBpqg%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fmined%2Ffiles%2Fmined%2Fmined%2520${PV}%2Fmined-${P}.tar.gz%2Fdownload -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
DEPEND="${RDEPEND}"
S=${S}/src
src_configure() {
	tc-export CC
	sed -in 's/OBJDIR=..\/bin\/sh/OBJDIR=bin\/sh/' mkmined
	sed -in 's/\"\${COPT--DTERMIO \$W}\"/\"${CFLAGS} \${COPT--DTERMIO} \${LDFLAGS}\"/' mkmined
	sed -in 's/name.o/name.o \$LDFLAGS/' mkmined
	sed -in 's/link=false/link=true/' mkmined
	sed -in 142's/$/ \$LDFLAGS/' mkmined
}

src_compile() {
	mkdir bin/
	./mkmined
}

src_install() {
	dobin bin/sh/mined
	doman ../man/mined.1
}
