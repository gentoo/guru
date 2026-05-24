# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{12..14} )

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
		$(python_gen_cond_dep 'dev-python/distro[${PYTHON_USEDEP}]')
	)
"

src_prepare() {
	default
	if [[ ! "${PV}" == "9999" ]] ; then
		# https://github.com/verilator/verilator/issues/3352
		sed -i "s/UNKNOWN_REV/(Gentoo ${PVR})/g" "${S}"/src/config_rev || die
	fi
	# https://bugs.gentoo.org/785151
	# Word-boundary match to avoid mangling python3_version etc. (bug 975566).
	sed -i "s/\<python3\>/${EPYTHON}/g" "${S}"/configure.ac || die
	find . -name "Makefile" -exec sed -i "s/\<python3\>/${EPYTHON}/g" {} + || die
	find test_regress -type f -exec sed -i "s/\<python3\>/${EPYTHON}/g" {} + || die
	python_fix_shebang .
	# https://bugs.gentoo.org/887917 and https://bugs.gentoo.org/975970
	# Upstream hard-codes -O3 / -Og / -ggdb / -gz / -Os / -O0, overriding user
	# CFLAGS/CXXFLAGS. The previous attempt targeted CFG_*_DEBUG which does not
	# exist in verilator's configure.ac (real names use _DBG), so the sed was
	# a silent no-op. Fix every injection point.
	local v
	for v in CFG_CXXFLAGS_OPT CFG_CXXFLAGS_DBG CFG_LDFLAGS_DBG ; do
		sed -i "/AC_SUBST(${v})/i ${v}=\"\"" "${S}"/configure.ac || die
	done
	sed -i -e 's/^OPT_FAST = .*/OPT_FAST =/' \
		-e 's/^OPT_GLOBAL = .*/OPT_GLOBAL =/' \
		"${S}"/include/verilated.mk.in || die
	sed -i -e 's/"OPT_FAST=-O0"/""/g' \
		-e 's/"OPT_GLOBAL=-O0"/""/g' \
		-e 's/"-Os" if param\[.benchmark.\] else "-O0"/"" if True else ""/g' \
		"${S}"/test_regress/driver.py || die
	find "${S}"/examples -name Makefile_obj -exec sed -i \
		-e 's/^OPT_FAST = .*/OPT_FAST =/' \
		-e 's/^OPT_SLOW = .*/OPT_SLOW =/' \
		-e 's/^OPT_GLOBAL = .*/OPT_GLOBAL =/' {} + || die
	eautoconf --force
}

src_configure() {
	# https://bugs.gentoo.org/887919
	econf CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	emake test
}
