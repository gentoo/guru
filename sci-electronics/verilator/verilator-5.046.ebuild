# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{11..14} )

inherit autotools python-single-r1

DESCRIPTION="The fast free Verilog/SystemVerilog simulator"
HOMEPAGE="
	https://verilator.org
	https://github.com/verilator/verilator
"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
fi

LICENSE="|| ( Artistic-2 LGPL-3 )"
SLOT="0"
IUSE="debug test"
RESTRICT="!test? ( test )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="
	${PYTHON_DEPS}
	dev-lang/perl
	virtual/zlib:=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	test? (
		dev-build/cmake
		dev-debug/gdb
	)
"

src_prepare() {
	default
	if [[ ! "${PV}" == "9999" ]] ; then
		# https://github.com/verilator/verilator/issues/3352
		sed -i "s/UNKNOWN_REV/(Gentoo ${PVR})/g" "${S}"/src/config_rev || die
	fi
	# https://bugs.gentoo.org/785151
	sed -i "s/python3/${EPYTHON}/g" "${S}"/configure.ac || die
	find . -name "Makefile" -exec sed -i "s/python3/${EPYTHON}/g" {} + || die
	find test_regress -type f -exec sed -i "s/python3/${EPYTHON}/g" {} + || die
	python_fix_shebang .
	# https://bugs.gentoo.org/887917
	if ! use debug; then
		sed -i '/AC_SUBST(CFG_CXXFLAGS_DEBUG)/i CFG_CXXFLAGS_DEBUG=""' "${S}"/configure.ac || die
		sed -i '/AC_SUBST(CFG_LDFLAGS_DEBUG)/i CFG_LDFLAGS_DEBUG=""' "${S}"/configure.ac || die
	fi
	eautoconf --force
}

src_configure() {
	# https://bugs.gentoo.org/887919
	econf CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	emake test
}
