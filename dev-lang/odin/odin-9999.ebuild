# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {17..21} )
inherit flag-o-matic llvm-r2

DESCRIPTION="The Data-Oriented Language for Sane Software Development."
HOMEPAGE="https://odin-lang.org/"

if [[ $PV == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/odin-lang/Odin.git"
	inherit git-r3
else
	MY_PV="${PV/./-}"
	SRC_URI="https://github.com/odin-lang/Odin/archive/refs/tags/dev-${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/Odin-dev-${MY_PV}"
	KEYWORDS="~amd64"
fi

LICENSE="ZLIB"
SLOT="0"

RDEPEND="
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/llvm:${LLVM_SLOT}=
	')
"

BDEPEND="${RDEPEND}"

src_configure() {
	strip-flags
	default
}

src_compile() {
	./build_odin.sh release || die "failed to build odin"
}

src_install() {
	local install_dir="/usr/$(get_libdir)/${PN}"
	insinto "${install_dir}"
	doins -r base core vendor

	# Odin needs to link against runtime libs. Odin can pick up on those libs
	# via `ODIN_ROOT`, but installing it into the same base dir keeps everything
	# working right out of the box.
	exeinto "${install_dir}"
	doexe odin
	dosym -r "${install_dir}/odin" "/usr/bin/odin"
}
