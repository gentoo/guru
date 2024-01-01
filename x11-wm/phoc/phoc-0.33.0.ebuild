# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson virtualx xdg

DESCRIPTION="Wayland compositor for mobile phones"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phoc"
SRC_URI="https://sources.phosh.mobi/releases/${PN}/${P}.tar.xz"

LICENSE="|| ( GPL-3+ MIT ) GPL-3+ LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+X gtk-doc man test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-libs/glib-2.70:2
	dev-libs/json-glib
	dev-libs/libinput:=
	dev-libs/wayland
	>=gnome-base/gnome-desktop-3.26:3
	gnome-base/gsettings-desktop-schemas
	>=gui-libs/wlroots-0.16.0:=[X?]
	<gui-libs/wlroots-0.17.0
	media-libs/libglvnd
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/libxkbcommon[X?,wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/glib:2
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	sys-devel/gettext
	gtk-doc? ( dev-util/gi-docgen )
	man? ( dev-python/docutils )
	test? ( x11-wm/mutter )
"

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
		$(meson_use gtk-doc gtk_doc)
		$(meson_use man)
		$(meson_use test tests)
		-Dembed-wlroots=disabled
	)
	meson_src_configure
}

src_test() {
	local -x LC_ALL="C.UTF-8"
	local -x WLR_RENDERER="pixman"

	virtx meson_src_test
}

src_install() {
	meson_src_install

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
