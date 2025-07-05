# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=(14 17 18 19 20)
inherit llvm-r1

DESCRIPTION="The Data-Oriented Language for Sane Software Development."

HOMEPAGE="https://odin-lang.org/"

if [[ $PV == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/odin-lang/Odin.git"
	inherit git-r3
else
	MY_PV="${PV/./-}"
	SRC_URI="https://github.com/odin-lang/Odin/archive/refs/tags/dev-${MY_PV}.tar.gz"
	# Source directory; the dir where the sources can be found (automatically
	# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
	# If you don't need to change it, leave the S= line out of the ebuild
	# to keep it tidy.
	S="${WORKDIR}/Odin-dev-${MY_PV}"
	KEYWORDS="~amd64"
fi


LICENSE="BSD"

SLOT="0"

RDEPEND="
$(llvm_gen_dep '
llvm-core/clang:${LLVM_SLOT}=
llvm-core/llvm:${LLVM_SLOT}=
')
"

DEPEND="${RDEPEND}"

# build_odin.sh sets its own flags. Some gcc flags cause build failures
CPPFLAGS=""
CXXFLAGS=""
src_compile() {
	./build_odin.sh release || die "failed to build odin"
}

src_install() {
	insinto usr/lib/odin
	exeinto usr/lib/odin

	doexe odin
	doins -r base core vendor
	dosym -r /usr/lib/odin/odin /usr/bin/odin
}
