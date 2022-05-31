# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="vapigen"
inherit meson vala

DESCRIPTION="DBus API that allows cloud storage sync clients to expose their services."
HOMEPAGE="https://gitlab.gnome.org/World/libcloudproviders"
SRC_URI="https://gitlab.gnome.org/World/libcloudproviders/-/archive/${PV}/libcloudproviders-${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="doc introspection vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND=">=dev-libs/glib-2.58.0:2"
DEPEND="
	${RDEPEND}
	introspection? ( dev-libs/gobject-introspection:= )
"
BDEPEND="
	$(vala_depend)
	dev-util/gdbus-codegen
	dev-util/glib-utils
	doc? (
		dev-util/gdbus-codegen
		dev-util/gtk-doc
	)
	virtual/pkgconfig
"

src_prepare() {
	default
	vala_setup
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
