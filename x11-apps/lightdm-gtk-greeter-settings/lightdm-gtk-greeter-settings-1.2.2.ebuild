# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 xdg-utils

DESCRIPTION="Configuration tool for the LightDM GTK Greeter"
HOMEPAGE="https://github.com/xubuntu/lightdm-gtk-greeter-settings"
SRC_URI="https://github.com/Xubuntu/${PN}/releases/download/${P}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="xfce"
RDEPEND="x11-misc/lightdm-gtk-greeter
		xfce? ( xfce-base/xfce4-settings )"
BDEPEND="dev-python/python-distutils-extra"

python_configure_all() {
	if use xfce; then
		DISTUTILS_ARGS=( --xfce-integration )
	fi
}

pkg_preinst() {
	rm -r "${D}/usr/share/doc/${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
