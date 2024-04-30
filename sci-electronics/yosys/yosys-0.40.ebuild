# Copyright 1999-2024 Gentoo Authors

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
	sys-devel/clang
"

DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git"

QA_PRESTRIPPED="
	/usr/bin/yosys-filterlib
	/usr/bin/yosys-abc
"

src_prepare() {
	mv "${WORKDIR}/abc-${ABC_GIT_COMMIT}" "${S}"/abc || die
	default
}

src_install() {
	emake DESTDIR="${D}" PREFIX='/usr' install
}
