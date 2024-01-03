# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/${PN}.git"
	inherit git-r3
	S="${WORKDIR}/${PN}-${PV}"
else
	COMMIT=2cc193e6dc524baed841c016109b4f48fd0512a3
	SPLITCOMMIT=2b1abdbf9e9de9ee660540167c8f51903fa3d959
	SRC_URI="https://github.com/hyprwm/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

DESCRIPTION="A blazing fast wayland wallpaper utility"
HOMEPAGE="https://github.com/hyprwm/hyprland-plugins"

LICENSE="BSD"
SLOT="0"
IUSE="+borders-plus-plus csgo-vulkan-fix +hyprbars"
REQUIRED_USE="|| ( borders-plus-plus csgo-vulkan-fix hyprbars )"

RDEPEND="gui-wm/hyprland"
DEPEND="${RDEPEND}"
BDEPEND="
	~gui-wm/hyprland-${PV}
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/xcb-util-wm
"

src_configure() {
	if use borders-plus-plus; then
		BUILD_DIR="${WORKDIR}/${P}-build/borders-plus-plus"
		EMESON_SOURCE="${S}/borders-plus-plus"
		meson_src_configure
	fi

	if use csgo-vulkan-fix; then
		BUILD_DIR="${WORKDIR}/${P}-build/csgo-vulkan-fix"
		EMESON_SOURCE="${S}/csgo-vulkan-fix"
		meson_src_configure
	fi

	if use hyprbars; then
		BUILD_DIR="${WORKDIR}/${P}-build/hyprbars"
		EMESON_SOURCE="${S}/hyprbars"
		meson_src_configure
	fi
}

src_compile() {
	if use borders-plus-plus; then
		BUILD_DIR="${WORKDIR}/${P}-build/borders-plus-plus"
		EMESON_SOURCE="${S}/borders-plus-plus"
		meson_src_compile
	fi

	if use csgo-vulkan-fix; then
		BUILD_DIR="${WORKDIR}/${P}-build/csgo-vulkan-fix"
		EMESON_SOURCE="${S}/csgo-vulkan-fix"
		meson_src_compile
	fi

	if use hyprbars; then
		BUILD_DIR="${WORKDIR}/${P}-build/hyprbars"
		EMESON_SOURCE="${S}/hyprbars"
		meson_src_compile
	fi
}

src_install() {
	insinto "/usr/share/hyprland/plugins"

	if use borders-plus-plus; then
		newins "${WORKDIR}/${P}-build/borders-plus-plus/libborders-plus-plus.so" "borders-plus-plus.so"
	fi

	if use csgo-vulkan-fix; then
		newins "${WORKDIR}/${P}-build/csgo-vulkan-fix/libcsgo-vulkan-fix.so" "csgo-vulkan-fix.so"
	fi

	if use hyprbars; then
		newins "${WORKDIR}/${P}-build/hyprbars/libhyprbars.so" "hyprbars.so"
	fi
}

pkg_postinst() {
	einfo "Plugins are installed in /usr/share/hyprland/plugins"
	einfo "To load them, refer to the official documentation"
	einfo "https://wiki.hyprland.org/Plugins/Using-Plugins/"
}
