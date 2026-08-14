EAPI=8

inherit cmake

DESCRIPTION="The C3 programming language compiler"
HOMEPAGE="https://c3-lang.org/"
SRC_URI="https://github.com/c3lang/c3c/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=llvm-core/llvm-17:=
	>=llvm-core/clang-17:=
	>=llvm-core/lld-17:=
	dev-libs/libffi
	virtual/zlib:=
	net-misc/curl
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DC3_LINK_DYNAMIC=ON
	)
	cmake_src_configure
}
