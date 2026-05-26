# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit meson-multilib

DESCRIPTION="A vulkan post processing layer"
HOMEPAGE="https://github.com/pchome/VulkanFX"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/pchome/VulkanFX.git"
	EGIT_SUBMODULES=()
	inherit git-r3
	SRC_URI=""
else
	SRC_URI="https://github.com/pchome/VulkanFX/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64"
	S="${WORKDIR}/VulkanFX-${PV}"
fi

LICENSE="ZLIB"
SLOT="0"

RESTRICT="test"

RDEPEND="!<media-libs/vulkan-loader-1.1:=[${MULTILIB_USEDEP},layers]
	!media-gfx/vkBasalt
	>=dev-util/reshade-fx-5.9.2"

BDEPEND="!<dev-util/vulkan-headers-1.1
	dev-util/glslang
	dev-libs/stb
	>=dev-build/meson-0.50"

DEPEND="${RDEPEND}"

multilib_src_configure() {
	local emesonargs=(
		--unity=on
		-Dunity_size=100
	)
	meson_src_configure
}

multilib_src_install() {
	meson_src_install
}
