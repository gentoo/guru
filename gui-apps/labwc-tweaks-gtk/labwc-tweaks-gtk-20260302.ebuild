# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

MY_COMMIT="ebdabbb818703bcd7906e95682855fd63539b8cf"

DESCRIPTION="A GTK fork of labwc-tweaks"
HOMEPAGE="https://github.com/labwc/labwc-tweaks-gtk"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/labwc/labwc-tweaks-gtk.git"
else
	SRC_URI="https://github.com/labwc/labwc-tweaks-gtk/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_COMMIT}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	dev-libs/libxml2
	x11-libs/pango
"
DEPEND="${RDEPEND}"
