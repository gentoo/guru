# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit meson xdg-utils

DESCRIPTION="A window switcher, run dialog and dmenu replacement"
HOMEPAGE="https://github.com/lbonn/rofi"
SRC_URI="https://github.com/lbonn/rofi/releases/download/${PV}%2Bwayland1/rofi-${PV}+wayland1.tar.xz"
S=${WORKDIR}/rofi-${PV}+wayland1

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+drun test +windowmode"
RESTRICT="!test? ( test )"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"
RDEPEND="
	dev-libs/glib:2
	x11-libs/cairo[X,xcb(+)]
	x11-libs/gdk-pixbuf:2
	x11-libs/pango[X]
	x11-libs/startup-notification
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-wm
	x11-misc/xkeyboard-config
	dev-libs/wayland
	dev-libs/wayland-protocols
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
	test? ( >=dev-libs/check-0.11 )
"

src_configure() {
	local emesonargs=(
	    -Dwayland=enabled
		-Dxcb=disabled
		$(meson_use drun)
		$(meson_use windowmode window)
	)
	meson_src_configure
}

pkg_postinst() {
	for v in ${REPLACING_VERSIONS}; do
		if ver_test "${v}" -lt 1.7.0; then
			elog "Rofi 1.7.0 removed the (deprecated) xresources based configuration setup."
			elog "If you are still using old configuration setup, please convert it to new format manually."
			elog "The new format configuration can be generated by 'rofi -dump-config > ~/.config/rofi/config.rasi'."
			elog "For more information, please see https://github.com/davatorium/rofi/releases/tag/1.7.0"
		fi
	done

	xdg_icon_cache_update
}

