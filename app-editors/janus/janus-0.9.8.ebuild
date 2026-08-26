# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="Simple native GTK text editor with binary editing fallback"
HOMEPAGE="https://pantheum.dev/janus https://github.com/gholmann16/Janus"
SRC_URI="https://github.com/gholmann16/Janus/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/Janus-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/gtksourceview:4
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/gettext"
