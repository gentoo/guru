# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The OpenCilk concurrency platform for parallel programming"
HOMEPAGE="https://opencilk.org/"

SRC_URI="https://github.com/OpenCilk/opencilk-project/releases/download/opencilk%2Fv${PV}/opencilk-${PV}.0-x86_64-linux-gnu-ubuntu-22.04.tar.gz"

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

S="${WORKDIR}"

QA_FLAGS_IGNORED="opt/${P}/.*"

src_install() {
	local target="opt/${P}"
	dodir "${target}"
	mv opencilk-2.1.0-x86_64-linux-gnu-ubuntu-22.04/* "${ED}/${target}" || die
}
