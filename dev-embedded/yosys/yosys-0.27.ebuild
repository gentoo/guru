# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 )
inherit python-any-r1

ABC_COMMIT="2c1c83f75b8078ced51f92c697da3e712feb3ac3"

SRC_URI="https://github.com/YosysHQ/yosys/archive/refs/tags/yosys-${PV}.tar.gz
https://github.com/YosysHQ/abc/archive/${ABC_COMMIT}.tar.gz -> yosys-abc-${ABC_COMMIT}.tar.gz"

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-libs/readline:=
	dev-libs/libffi:=
	dev-vcs/git
	dev-lang/tcl:="

DEPEND="
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	${RDEPEND}"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	ln -s "${WORKDIR}/abc-${ABC_COMMIT}" abc
	default
}

src_configure() {
	emake config-gcc
}

src_compile() {
	emake PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake PREFIX="${ED}/usr" STRIP=true install
}
