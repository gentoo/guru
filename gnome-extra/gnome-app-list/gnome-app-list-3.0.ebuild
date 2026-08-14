# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome.org meson

DESCRIPTION="Recommendation app data for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gnome-app-list"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-libs/libxml2
"
