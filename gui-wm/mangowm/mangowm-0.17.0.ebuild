# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="mango"
MY_P=${MY_PN}-${PV}

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mangowm/mango.git"
else
	SRC_URI="https://github.com/mangowm/mango/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A fast, feature-rich Wayland compositor built on dwl"
HOMEPAGE="
	https://github.com/mangowm/mango
	https://mangowm.github.io
"

LICENSE="CC0-1.0 GPL-3+ MIT"
SLOT="0"

DOCS=(
	README.md
	.github/CONTRIBUTING.md
)

IUSE="X asan"

RDEPEND="
	>=gui-libs/wlroots-0.20:=[libinput,session,X?]
	<gui-libs/wlroots-0.21:=[X?]
	>=gui-libs/scenefx-0.5:0.5

	dev-libs/cJSON
	dev-libs/glib
	dev-libs/libinput:=
	dev-libs/libpcre2
	dev-libs/wayland

	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman

	X? (
		x11-base/xwayland
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
"

DEPEND="
	${RDEPEND}
	sys-kernel/linux-headers
"

BDEPEND="
	>=dev-build/meson-0.60.0
	>=dev-libs/wayland-protocols-1.32
	>=dev-util/wayland-scanner-1.23
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
		$(meson_use asan)
	)

	meson_src_configure
}
