# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_USE_DEPEND="vapigen"

inherit meson vala

DESCRIPTION="DBus API that allows cloud storage sync clients to expose their services."
HOMEPAGE="https://gitlab.gnome.org/World/libcloudproviders"
SRC_URI="https://gitlab.gnome.org/World/libcloudproviders/-/archive/${PV}/libcloudproviders-${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc introspection vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	>=dev-libs/glib-2.58.0:2
"
DEPEND="${RDEPEND}
	introspection? ( dev-libs/gobject-introspection:= )
"
BDEPEND="$(vala_depend)
	doc? ( dev-util/gdbus-codegen )
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	default
}
src_configure() {
	local emesonargs=(
		$(meson_use vala vapigen)
		$(meson_use introspection)
		$(meson_use doc enable-gtk-doc)
		-Dinstalled-tests=false
	)
	meson_src_configure
}
