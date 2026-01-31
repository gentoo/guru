# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Scalable Video Technology for VP9 (SVT-VP9 Encoder)"
HOMEPAGE="https://github.com/OpenVisualCloud/SVT-VP9"

if [ ${PV} = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/OpenVisualCloud/SVT-VP9.git"
else
	SRC_URI="
		https://github.com/OpenVisualCloud/SVT-VP9/archive/v${PV}.tar.gz
			-> ${P}.tar.gz
	"

	KEYWORDS="~amd64"
	S="${WORKDIR}/SVT-VP9-${PV}"
fi

LICENSE="BSD-2-with-patent"
SLOT="0/1"

BDEPEND="dev-lang/nasm"

src_prepare() {
	# https://bugs.gentoo.org/901289
	sed -i \
	's/\(-fPIE\|-fPIC\|-D_FORTIFY_SOURCE=2\|-fstack-protector-strong\)\s*//g' \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		)

	cmake_src_configure
}
