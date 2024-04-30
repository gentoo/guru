# Copyright 1999-2024 Gentoo Authors

EAPI=8

# get the current value from the yosys makefile...look for ABCREV
ABC_GIT_COMMIT=bb64142b07794ee685494564471e67365a093710

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

PATCHES=(
	"${FILESDIR}/${PN}-0.31-abc-c++17-fix.patch"
)

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
