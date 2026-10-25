EAPI=8

inherit cmake

DESCRIPTION="The C3 programming language compiler"
HOMEPAGE="https://c3-lang.org/"
SRC_URI="https://github.com/c3lang/c3c/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

LLVM_COMPAT=( {19..24} )
inherit llvm-r2

DEPEND="
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/llvm:${LLVM_SLOT}=
		llvm-core/lld:${LLVM_SLOT}=
	')
	dev-libs/libffi
	virtual/zlib:=
	net-misc/curl
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DC3_LINK_DYNAMIC=ON
		-DC3_FETCH_LLVM=OFF
	)
	cmake_src_configure
}
