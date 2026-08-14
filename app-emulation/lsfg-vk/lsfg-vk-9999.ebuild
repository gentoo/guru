# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lossless Scaling Frame Generation on Linux via DXVK/Vulkan"
HOMEPAGE="https://github.com/PancakeTAS/lsfg-vk"
LICENSE="GPL-3"
SLOT="0"
IUSE="cli +gui"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PancakeTAS/lsfg-vk"
else
	KEYWORDS="~amd64 ~arm64"
	SRC_URI="https://github.com/PancakeTAS/lsfg-vk/archive/refs/tags/v${PV}.tar.gz -> lsfg-vk-${PV}.tar.gz"
fi

BDEPEND="
	dev-util/vulkan-headers
"
DEPEND="
	dev-util/glslang
	gui? (
		dev-qt/qtbase:6
		dev-qt/qtdeclarative:6
	)
	media-libs/libglvnd
	media-libs/vulkan-loader
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} != 9999 ]]; then
		default
	else
		git-r3_src_unpack
	fi
}

src_prepare() {
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLSFGVK_BUILD_CLI=$(usex cli)
		-DLSFGVK_BUILD_UI=$(usex gui)
		-DLSFGVK_INSTALL_XDG_FILES=$(usex gui)
	)
	cmake_src_configure
}
