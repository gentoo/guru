# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="The theme from libadwaita ported to GTK-3"
HOMEPAGE="https://github.com/lassekongo83/adw-gtk3"
SRC_URI="https://github.com/lassekongo83/adw-gtk3/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IDEPEND=">=dev-lang/sassc-3.6.2"
