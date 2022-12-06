# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Multi Criteria CUDF Solver"
HOMEPAGE="https://www.i3s.unice.fr/~cpjm/misc/mccs.html"
SRC_URI="
	https://www.i3s.unice.fr/~cpjm/misc/${P}-srcs.tgz
	http://deb.debian.org/debian/pool/main/m/mccs/${PN}_${PV}-9.debian.tar.xz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="glpk lpsolve"

DEPEND="
	glpk? ( sci-mathematics/glpk )
	lpsolve? ( sci-mathematics/lpsolve )
"
RDEPEND="
	${DEPEND}
	sci-libs/coinor-cbc
"

BDEPEND="
	dev-util/quilt
	sys-devel/bison
	app-alternatives/yacc
"

src_prepare() {
	export QUILT_PATCHES="${WORKDIR}/debian/patches"
	export QUILT_SERIES="${QUILT_PATCHES}/series"
	quilt push -a || die
	eapply "${FILESDIR}/${P}-respect-flags.patch"
	eapply "${FILESDIR}/${P}-glpk.patch"
	eapply "${FILESDIR}/${P}-fix-Wl.patch"
	eapply "${FILESDIR}/${P}-respect-AR.patch"
	eapply_user

	if use glpk; then
		sed \
			-e "s|#USEGLPK=1|USEGLPK=1|g" \
			-e "s|GLPKDIR=/usr/lib|GLPKDIR=/usr/$(get_libdir)|g" \
			-i make.local || die
	fi
	if use lpsolve; then
		sed -e "s|LPSOLVEDIR=/usr/lib|LPSOLVEDIR=/usr/$(get_libdir)|g" -i make.local || die
	else
		sed -e "s|USELPSOLVE=1|#USELPSOLVE=1|g" -i make.local || die
	fi
}

src_compile() {
	tc-export AR CXX
	append-cxxflags "-std=c++14"
	MAKEOPTS="-j1" emake libccudf.so
	MAKEOPTS="-j1" emake mccs
}

src_install() {
	dodoc README CHANGES
	dodoc -r examples

	insinto /usr/share/cudf/solvers
	doins "${FILESDIR}/mccs-cbc"
	use lpsolve && doins "${FILESDIR}/mccs-lpsolve"

	dobin sciplp cbclp wbopb mccs
	exeinto "/usr/libexec/${PN}"
	doexe solve{paranoid,trendy}
	dolib.so libccudf.so
}
