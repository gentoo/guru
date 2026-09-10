# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )
PYTHON_REQ_USE="threads(+)"

inherit gnome.org gnome2-utils meson xdg python-single-r1

DESCRIPTION="Video player for GNOME"
HOMEPAGE="https://apps.gnome.org/Showtime/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"

DEPEND="${PYTHON_DEPS}
	>=gui-libs/gtk-4.18.0:4
	>=dev-libs/gobject-introspection-1.86.0:=
	>=dev-util/blueprint-compiler-0.17
	>=media-plugins/gst-plugin-gtk4-0.13.4:1.0
	dev-python/pygobject:3
"

RDEPEND="${DEPEND}
	>=media-plugins/gst-plugins-gtk-1.21.1:1.0
	>=media-plugins/gst-plugins-meta-1.21.1:1.0
	>=media-plugins/gst-plugins-taglib-1.21.1:1.0
	>=gui-libs/libadwaita-1.8_alpha:1
	x11-themes/adwaita-icon-theme
"

BDEPEND="
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local emesonargs=(
		-Dprofile=release
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_fix_shebang "${ED}"/usr/bin/showtime
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
