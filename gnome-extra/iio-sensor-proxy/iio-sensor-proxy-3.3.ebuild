# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg gnome2-utils meson

DESCRIPTION="IIO sensors to D-Bus proxy"
HOMEPAGE="https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/"
SRC_URI="https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+systemd"
RESTRICT="test"

RDEPEND="
	dev-libs/glib:*
	gnome-base/gnome-common
	>=dev-libs/libgudev-237
	systemd? (
		!sys-apps/openrc
		sys-apps/systemd
	)
	virtual/udev
"

DEPEND="
	${RDEPEND}
	dev-build/gtk-doc-am
	virtual/pkgconfig
"

src_install() {
	meson_src_install
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
