# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

NO_DOT_PV=$(ver_rs 1- '')
DESCRIPTION="A free file archiver for extremely high compression"
HOMEPAGE="https://www.7-zip.org/ https://sourceforge.net/projects/sevenzip/"
SRC_URI="https://sourceforge.net/projects/sevenzip/files/7-Zip/${PV}/7z${NO_DOT_PV}-src.tar.xz/download -> ${PN}-${PV}.tar.xz"
LICENSE="LGPL-2 BSD"

IUSE="asm"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/CPP/7zip/"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="asm? ( dev-lang/jwasm )"

pkg_setup() {
	# instructions in DOC/readme.txt, Compiling 7-Zip for Unix/Linux
	# TLDR; every combination of options (clang|gcc)+(asm/noasm)
	# has a dedicated makefile & builddir
	mfile="cmpl"
	if tc-is-clang; then
		mfile="${mfile}_clang"
		bdir=c
	elif tc-is-gcc; then
		mfile="${mfile}_gcc"
		bdir=g
	else
		die "Unsupported compiler: $(tc-getCC)"
	fi
	if use asm ; then
		mfile="${mfile}_x64"
		bdir="${bdir}_x64"
	fi
	export mfile="${mfile}.mak"
	export bdir
}

src_prepare() {
	default
	sed -i -e 's/-Werror //g' ./7zip_gcc.mak || die "Error removing -Werror"
	sed -i -e 's/$(LFLAGS_STRIP)//g' ./7zip_gcc.mak \
		|| die "Error removing hardcoded strip"
}

src_compile() {
	pushd "./Bundles/Alone2" || die "Unable to switch directory"
	# USE_JWASM=1 - if asm: use JWasm assembler instead of Asmc (not a gentoo package)
	emake DISABLE_RAR=1 USE_JWASM=1 --file "../../${mfile}"
	popd > /dev/null || die "Unable to switch directory"
}

src_install() {
	dobin "./Bundles/Alone2/b/${bdir}/7zz"
}
