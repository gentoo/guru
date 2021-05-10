# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

FONT_SUFFIX="otf"
FONT_PN="Inconsolata_dz"

inherit font

DESCRIPTION="A beautiful sans-serif monotype font designed for code listings"
HOMEPAGE="
	https://nodnod.net/posts/inconsolata-dz
	https://fontinfo.opensuse.org/fonts/Inconsolata-dzdz.html
"
SRC_URI="https://nodnod.net/posts/inconsolata-dz/files/${FONT_PN}.${FONT_SUFFIX}"
S="${DISTDIR}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
