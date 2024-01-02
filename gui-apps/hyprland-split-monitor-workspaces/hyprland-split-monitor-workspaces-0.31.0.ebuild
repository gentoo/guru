# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
M_PN="split-monitor-workspaces"

inherit meson

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/Duckonaut/${M_PN}.git"
	inherit git-r3
else
	COMMIT=2b1abdbf9e9de9ee660540167c8f51903fa3d959
	SRC_URI="https://github.com/Duckonaut/${M_PN}/archive/${COMMIT}.tar.gz \
		-> ${P}.gh.tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${M_PN}-${COMMIT}"
fi

DESCRIPTION="A small plugin to provide awesome/dwm-like behavior with workspaces"
HOMEPAGE="https://github.com/Duckonaut/split-monitor-workspaces"

LICENSE="BSD"
SLOT="0"

RDEPEND="gui-wm/hyprland"
DEPEND="${RDEPEND}"
BDEPEND="
	~gui-wm/hyprland-${PV}
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/xcb-util-wm
"

src_compile() {
	emake -C "${S}" split-monitor-workspaces.so
}

src_install() {
	insinto "/usr/share/hyprland/plugins"
	doins "${S}/split-monitor-workspaces.so"
}

pkg_postinst() {
	einfo "Plugins are installed in /usr/share/hyprland/plugins"
	einfo "To load them, refer to the official documentation"
	einfo "https://wiki.hyprland.org/Plugins/Using-Plugins/"
}
