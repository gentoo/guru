# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare-adwaita"
	SLOT="0"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/hare-adwaita/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="Hare bindings for libadwaita"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hare-adwaita"
LICENSE="MPL-2.0"

DEPEND="
	>=dev-lang/hare-0.25.2
	>=dev-hare/hare-gi-0.1.0[gtk4]
	>=dev-libs/glib-2.80.5[introspection]
	dev-libs/gobject-introspection
	dev-libs/atk[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	media-libs/harfbuzz[introspection]
	x11-libs/pango[introspection]
	gui-libs/gtk:4[introspection]
	media-libs/graphene[introspection]
	gui-libs/libadwaita[introspection]
"

src_prepare() {
	default
	sed -i 's;^PREFIX = .*;PREFIX = /usr;' Makefile || die
}
