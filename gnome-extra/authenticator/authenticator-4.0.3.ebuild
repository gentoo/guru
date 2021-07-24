# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils git-r3 xdg

DESCRIPTION="Simple application for generating Two-Factor Authentication Codes."
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="https://gitlab.gnome.org/World/Authenticator/-/archive/${PV}/${PN}-${PV}.tar.gz"
EGIT_REPO_URI="https://gitlab.gnome.org/World/Authenticator.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	gnome-base/gnome-common
	gui-libs/gtk
	x11-libs/libadwaita
	x11-libs/gdk-pixbuf
	>=media-libs/gstreamer-1.18.0
	"
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
		"

S="${WORKDIR}/$PN-${PV}"

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
