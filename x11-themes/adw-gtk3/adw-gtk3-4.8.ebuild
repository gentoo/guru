# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="The theme from libadwaita ported to GTK-3"
HOMEPAGE="https://github.com/lassekongo83/adw-gtk3"
SRC_URI="https://github.com/lassekongo83/adw-gtk3/archive/refs/tags/v${PV}.tar.gz"
S="${WORKDIR}/adw-gtk3-${PV}"

LICENSE="LGPG-2.1"
SLOT="0"
KEYWORDS="~amd64"

IDEPEND=">=dev-lang/sassc-3.6.2"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	meson_src_install

	einfo "# Change the theme to adw-gtk3 light"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' && gsettings set org.gnome.desktop.interface color-scheme 'default'"
	einfo "# Change the theme to adw-gtk3-dark"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
	einfo "# Revert to GNOME's default theme"
	einfo "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' && gsettings set org.gnome.desktop.interface color-scheme 'default'"
}
