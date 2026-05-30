# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

DESCRIPTION="TUI web browser; supports CSS, images, JavaScript, and multiple web protocols"
HOMEPAGE="https://chawan.net"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~bptato/${PN}"
else
	SRC_URI="https://git.sr.ht/~bptato/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="Unlicense"

SLOT="0"

IUSE="lto"

DEPEND="
	app-arch/brotli
	dev-libs/openssl
	net-libs/libssh2
"
BDEPEND="
	dev-lang/nim
	virtual/pkgconfig
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/makefile-491b4231.patch"
)

src_prepare(){
	default
	if use lto; then
		sed -i -E 's|^FLAGS\s+\+=.+|& -d:lto|' Makefile ||
		die "Trying to sed the Makefile for lto failed!"
	fi
}

src_configure(){
	# code is mostly copy pasted from the nim_gen_config() function from nim-utils.eclass, modifed a bit to actually
	# append to the original nim.cfg, instead of replacing it
	cat >> "${S}"/nim.cfg <<- EOF || die "Failed to append to Nim config"
		--parallelBuild:"$(makeopts_jobs)"

		cc:"gcc"
		gcc.exe:"$(tc-getCC)"
		gcc.linkerexe:"$(tc-getCC)"
		gcc.cpp.exe:"$(tc-getCXX)"
		gcc.cpp.linkerexe:"$(tc-getCXX)"
		gcc.options.speed:"${CFLAGS}"
		gcc.options.size:"${CFLAGS}"
		gcc.options.debug:"${CFLAGS}"
		gcc.options.always:"${CPPFLAGS}"
		gcc.options.linker:"${LDFLAGS}"
		gcc.cpp.options.speed:"${CXXFLAGS}"
		gcc.cpp.options.size:"${CXXFLAGS}"
		gcc.cpp.options.debug:"${CXXFLAGS}"
		gcc.cpp.options.always:"${CPPFLAGS}"
		gcc.cpp.options.linker:"${LDFLAGS}"
		EOF
	default
}
