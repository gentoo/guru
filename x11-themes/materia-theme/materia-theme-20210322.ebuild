# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A Material Design theme for GNOME/GTK based desktop environments"
HOMEPAGE="https://github.com/nana-4/materia-theme"
SRC_URI="https://github.com/nana-4/materia-theme/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/gdk-pixbuf
	x11-themes/gnome-themes-standard
	x11-themes/gtk-engines-murrine
"
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/sassc"
