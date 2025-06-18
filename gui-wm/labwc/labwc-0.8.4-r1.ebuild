# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

DESCRIPTION="Openbox alternative for wayland"
HOMEPAGE="https://github.com/labwc/labwc"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/labwc/labwc"
else
	SRC_URI="https://github.com/labwc/labwc/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="X icons nls svg man static-analyzer test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/wayland-1.19
	dev-libs/glib:2
	>=dev-libs/libinput-1.14
	dev-libs/libxml2:2
	>=gui-libs/wlroots-0.18.1:0.18[X?]
	media-libs/libpng
	x11-libs/cairo[X?]
	x11-libs/libdrm:=
	x11-libs/libxkbcommon:=[X?]
	x11-libs/pango[X?]
	x11-libs/pixman
	nls? ( sys-devel/gettext )
	svg? ( >=gnome-base/librsvg-2.46 )
	X? ( x11-libs/libxcb:0= )
	X? ( x11-base/xwayland )
	icons? ( gui-libs/libsfdo )
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/wayland-protocols-1.35
	sys-devel/gettext
	virtual/pkgconfig
	man? ( app-text/scdoc )
	test? ( dev-util/cmocka )
"
PATCHES=(
	"${FILESDIR}"/${PN}-meson_doc_path.patch
)

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
		$(meson_feature nls)
		$(meson_feature svg)
		$(meson_feature icons icon)
		$(meson_feature man man-pages)
		$(meson_feature test)
		$(meson_feature static-analyzer static_analyzer)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
