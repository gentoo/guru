# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 xdg

DESCRIPTION="Configuration tool for the LightDM GTK Greeter"
HOMEPAGE="https://github.com/xubuntu/lightdm-gtk-greeter-settings"
SRC_URI="https://github.com/Xubuntu/${PN}/releases/download/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xfce"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]
	x11-misc/lightdm-gtk-greeter
	xfce? ( xfce-base/xfce4-settings )
	$(python_gen_cond_dep '
		dev-libs/gobject-introspection[${PYTHON_SINGLE_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	$(python_gen_cond_dep '
		dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	')
"

python_install() {
	distutils-r1_python_install $(usex xfce '--xfce-integration' '')
	rm -r "${ED}/usr/share/doc/${PN}" || die
}
