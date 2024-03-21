# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Plug-in for development GIMP 2.99.11 for loading/saving AVIF images."
HOMEPAGE="https://github.com/novomesk/gimp-avif-plugin"

EGIT_REPO_URI="https://github.com/novomesk/gimp-avif-plugin.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND=">=media-gfx/gimp-2.99.11
	>=media-libs/gexiv2-0.12.2
"


RDEPEND="${DEPEND}"
