# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools

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
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
fi

LICENSE="|| ( Artistic-2 LGPL-3 )"
SLOT="0"

RDEPEND="
	dev-lang/perl
	sys-libs/zlib
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

src_prepare() {
	default
	eautoconf --force
}
