# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="A simple color chooser written in GTK3"
HOMEPAGE="https://gitlab.gnome.org/World/gcolor3"
SRC_URI="https://gitlab.gnome.org/World/gcolor3/-/archive/v${PV}/gcolor3-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libportal[gtk]
	>=gui-libs/libhandy-1.5.0
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/gettext"

# NOTE: remove for next version
PATCHES=( "${FILESDIR}/${P}-update-to-libportal-0.5.patch" )

src_prepare() {
	# Updates desktop database and icon cache
	sed -i "/^meson\.add_install_script('meson_install\.sh'/d" meson.build \
		|| die "Could not remove install script from build recipe"

	default
}
