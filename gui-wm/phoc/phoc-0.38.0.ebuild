# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson verify-sig virtualx xdg

DESCRIPTION="Wayland compositor for mobile phones"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phoc"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz
	verify-sig? ( https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz.asc )
"

LICENSE="|| ( GPL-3+ MIT ) GPL-3+ LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="gtk-doc man test"
RESTRICT="!test? ( test )"

WLROOTS_DEPEND="
	>=dev-libs/libinput-1.14.0:=
	>=dev-libs/wayland-1.22.0
	media-libs/libdisplay-info
	media-libs/libglvnd
	media-libs/mesa[egl(+),gles2]
	sys-apps/hwdata
	sys-auth/seatd:=
	x11-base/xwayland
	x11-libs/cairo
	>=x11-libs/libdrm-2.4.114
	x11-libs/libxcb:=
	x11-libs/libxkbcommon
	>=x11-libs/pixman-0.42.0
	x11-libs/xcb-util-errors
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
	virtual/libudev
	amd64? ( >=dev-libs/libliftoff-0.4 )
"
COMMON_DEPEND="${WLROOTS_DEPEND}
	>=dev-libs/glib-2.74:2
	dev-libs/json-glib
	dev-libs/libinput:=
	dev-libs/wayland
	>=gnome-base/gnome-desktop-3.26:3
	gnome-base/gsettings-desktop-schemas
	x11-libs/pixman
	x11-libs/libxcb:=
	x11-libs/libxkbcommon
"
DEPEND="${COMMON_DEPEND}
	test? ( x11-wm/mutter )
"
RDEPEND="${COMMON_DEPEND}"
BDEPEND="
	dev-libs/glib:2
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	sys-devel/gettext
	gtk-doc? ( dev-util/gi-docgen )
	man? ( dev-python/docutils )
	verify-sig? ( sec-keys/openpgp-keys-phosh )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/phosh.asc"

src_prepare() {
	default

	cd subprojects/wlroots || die
	eapply "${S}"/subprojects/packagefiles/wlroots
}

src_configure() {
	local emesonargs=(
		$(meson_use gtk-doc gtk_doc)
		$(meson_use man)
		$(meson_use test tests)
		-Ddefault_library=static
		-Dembed-wlroots=enabled
		-Dxwayland=enabled
	)
	meson_src_configure
}

src_test() {
	local -x LC_ALL="C.UTF-8"
	virtx meson_src_test
}

src_install() {
	meson_src_install --skip-subprojects gmobile,wlroots

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/${PN}-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi

	newbin helpers/auto-maximize phoc-auto-maximize
	newbin helpers/scale-to-fit phoc-scale-to-fit
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
