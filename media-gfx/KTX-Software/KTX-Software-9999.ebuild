# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="KTX (Khronos Texture) Library and Tools"
HOMEPAGE="https://github.com/KhronosGroup/KTX-Software"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="tools"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KhronosGroup/KTX-Software.git"
	MY_PV=${EGIT_COMMIT}
else
	SRC_URI="https://github.com/KhronosGroup/KTX-Software/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

BDEPEND="
	app-shells/bash
"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.2-remove-O3.patch"
)

src_configure() {
	local mycmakeargs=(
		-DKTX_VERSION=${MY_PV-${PV}}
		-DKTX_FEATURE_TESTS=OFF
		-DKTX_FEATURE_TOOLS=$(usex tools)
	)

	cmake_src_configure
}
