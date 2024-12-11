# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# get the current value from the yosys makefile...look for ABCREV
ABC_GIT_COMMIT=0cd90d0d2c5338277d832a1d890bed286486bcf5

DESCRIPTION="framework for Verilog RTL synthesis"
HOMEPAGE="http://www.clifford.at/yosys/"
SRC_URI="
	https://github.com/YosysHQ/${PN}/archive/${P}.tar.gz
	https://github.com/YosysHQ/abc/archive/${ABC_GIT_COMMIT}.tar.gz -> abc-${ABC_GIT_COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${PN}-${PV}"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/boost
	media-gfx/xdot
	llvm-core/clang
"

DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git"

src_prepare() {
	mv "${WORKDIR}/abc-${ABC_GIT_COMMIT}" "${S}"/abc || die
	default
}

src_configure() {
	cat <<-__EOF__ >> Makefile.conf || die
		PREFIX := ${EPREFIX}/usr
		STRIP := @echo "skipping strip"
	__EOF__
	default
}
