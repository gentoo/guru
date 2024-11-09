# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="2D vector graphics library powered by a JIT compiler."
HOMEPAGE="https://blend2d.com/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
else
	SRC_URI="https://blend2d.com/download/${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="ZLIB"
SLOT="0"
IUSE="test"

RDEPEND=">=dev-libs/asmjit-2024.01.01"
DEPEND="${RDEPEND}"
RESTRICT="!test? ( test )"

DOCS=( README.md CONTRIBUTING.md )

src_configure() {
	local mycmakeargs=(
		-DBLEND2D_TEST=$(usex test)
		-DBLEND2D_EXTERNAL_ASMJIT=ON
	)
	cmake_src_configure
}
