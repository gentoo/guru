# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The OpenCilk concurrency platform for parallel programming"
HOMEPAGE="https://opencilk.org/"
SRC_URI="https://github.com/OpenCilk/opencilk-project/releases/download/opencilk%2Fv${PV}/OpenCilk-${PV}-LLVM-12.0.0-Ubuntu-20.04-x86_64.tar.gz"

S="${WORKDIR}"

# Since opencilk-project is a fork of LLVM 12, this lists the licenses
# of LLVM 12, while opencilk-project states that it us under "MIT with
# the OpenCilk Addendum", which basically states that you can
# distributed it under the LLVM licences. I am also not sure if OpenCilk
# is able to change the license of LLVM (which source code they use),
# hence this needs more investigation and we only list t he LLVM 12
# licenses, because those definetly are correct.
LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA BSD public-domain rc"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	dev-libs/libxml2
	sys-libs/ncurses:=
	sys-libs/zlib
"

QA_FLAGS_IGNORED="opt/${P}/.*"

src_install() {
	local target="opt/${P}"
	dodir "${target}"
	mv OpenCilk-12.0.0-Linux/* "${ED}/${target}" || die
}
