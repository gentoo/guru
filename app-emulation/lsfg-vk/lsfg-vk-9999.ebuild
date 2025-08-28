# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1

inherit cargo cmake desktop flag-o-matic toolchain-funcs

DESCRIPTION="Lossless Scaling Frame Generation on Linux via DXVK/Vulkan"
HOMEPAGE="https://github.com/PancakeTAS/lsfg-vk"
LICENSE="MIT"
SLOT="0"
IUSE="+gui"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PancakeTAS/lsfg-vk"
else
	KEYWORDS="~amd64 ~arm64"
	SRC_URI="
		https://github.com/PancakeTAS/lsfg-vk/archive/refs/tags/v${PV}.tar.gz -> lsfg-vk-${PV}.tar.gz
		${CARGO_CRATE_URIS}
	"
fi

BDEPEND="
	dev-util/vulkan-headers
	gui? ( ${RUST_DEPEND} )
"
DEPEND="
	dev-util/glslang
	gui? (
		dev-libs/glib:2
		gui-libs/gtk:4[introspection]
		gui-libs/libadwaita
	)
	|| (
		media-libs/glfw
		media-libs/libsdl2
		media-libs/libsdl3
	)
	media-libs/vulkan-loader
"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} != 9999 ]]; then
		use gui || default
	else
		git-r3_src_unpack
	fi

	if use gui; then
		if [[ ${PV} != 9999 ]]; then
			cargo_src_unpack
		else
			oldS="${S}"
			S="${S}/ui"
			cargo_live_src_unpack
			S="${oldS}"
		fi
	fi
}

src_prepare() {
	eapply_user
	cmake_src_prepare
}

src_configure() {
	tc-is-gcc && filter-lto # LTO with gcc causes segfaults at runtime
	cmake_src_configure
	use gui && { pushd ui > /dev/null || die; cargo_src_configure; }
}

src_compile() {
	cmake_src_compile
	use gui && { pushd ui > /dev/null || die; cargo_src_compile; }
}

src_install() {
	insinto "/usr/share/vulkan/implicit_layer.d/"
	doins "${S}/VkLayer_LS_frame_generation.json"
	dolib.so "${WORKDIR}/${P}_build/liblsfg-vk.so"
	if use gui; then
		dobin "${S}/ui/$(cargo_target_dir)/lsfg-vk-ui"
		domenu "${S}/ui/rsc/gay.pancake.lsfg-vk-ui.desktop"
		newicon -s 256 "${S}/ui/rsc/icon.png" "gay.pancake.lsfg-vk-ui.png"
	fi
}
