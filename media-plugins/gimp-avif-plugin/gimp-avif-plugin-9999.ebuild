# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit meson git-r3

DESCRIPTION="Plug-in for development GIMP 2.99.3 for loading/saving AVIF images."
HOMEPAGE="https://github.com/novomesk/gimp-avif-plugin"

EGIT_REPO_URI="https://github.com/novomesk/gimp-avif-plugin.git"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=">media-gfx/gimp-2.99
"

BDEPEND=""

RDEPEND="${DEPEND}"
