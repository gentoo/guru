# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT=bb1437add2df7f76147f7beb430365637fc2c35e
SPLITCOMMIT=feb6ab9a4929a92d41c724f6d16e9d351b12de39
DESCRIPTION="A blazing fast wayland wallpaper utility"
HOMEPAGE="https://github.com/hyprwm/hyprpaper"
SRC_URI="https://github.com/hyprwm/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/hyprwm/Hyprland/releases/download/v${PV}/source-v${PV}.tar.gz \
	-> ${P}-hyprsrc.gh.tar.gz
	https://github.com/Duckonaut/split-monitor-workspaces/archive/${SPLITCOMMIT}.tar.gz \
	-> ${P}-split-monitor-workspaces.gh.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+borders-plus-plus csgo-vulkan-fix +hyprbars split-monitor-workspaces X"
REQUIRED_USE="|| ( borders-plus-plus csgo-vulkan-fix hyprbars split-monitor-workspaces )"

RDEPEND="gui-wm/hyprland"
DEPEND="${RDEPEND}"
BDEPEND="
	~gui-wm/hyprland-${PV}
	split-monitor-workspaces? ( gui-libs/wlroots[X?] )
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/xcb-util-wm
"

src_unpack() {
	default
	cp "${FILESDIR}/split-monitor-workspaces.patch" "${WORKDIR}/split-monitor-workspaces-${SPLITCOMMIT}" || die
}

src_prepare() {
	eapply_user
	if use split-monitor-workspaces && ! use X; then
		cd "${WORKDIR}/split-monitor-workspaces-${SPLITCOMMIT}" || die
		eapply "${WORKDIR}/split-monitor-workspaces-${SPLITCOMMIT}"
	fi
}

src_compile() {
	emake -C "${WORKDIR}/hyprland-source" protocols
	export HYPRLAND_HEADERS="${WORKDIR}/hyprland-source"

	if use borders-plus-plus; then
		emake -C "${S}/borders-plus-plus" all
	fi

	if use csgo-vulkan-fix; then
		emake -C "${S}/csgo-vulkan-fix" all
	fi

	if use hyprbars; then
		emake -C "${S}/hyprbars" all
	fi

	if use split-monitor-workspaces; then
		emake -C "${WORKDIR}/split-monitor-workspaces-${SPLITCOMMIT}" split-monitor-workspaces.so
	fi
}

src_install() {
	insinto "/usr/share/hyprland/plugins"

	if use borders-plus-plus; then
		doins "${S}/borders-plus-plus/borders-plus-plus.so"
	fi

	if use csgo-vulkan-fix; then
		doins "${S}/csgo-vulkan-fix/csgo-vulkan-fix.so"
	fi

	if use hyprbars; then
		doins "${S}/hyprbars/hyprbars.so"
	fi

	if use split-monitor-workspaces; then
		doins "${WORKDIR}/split-monitor-workspaces-${SPLITCOMMIT}/split-monitor-workspaces.so"
		emake -C "${WORKDIR}/split-monitor-workspaces-${SPLITCOMMIT}" all
	fi
}

pkg_postinst() {
	einfo "Plugins are installed in /usr/share/hyprland/plugins"
	einfo "To load them, refer to the official documentation"
	einfo "https://wiki.hyprland.org/Plugins/Using-Plugins/"
}
