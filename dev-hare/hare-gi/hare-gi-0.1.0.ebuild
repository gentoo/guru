# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~yerinalexey/hare-gi"
	SLOT="0"
else
	SRC_URI="https://git.sr.ht/~yerinalexey/hare-gi/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="GObject Introspection code generator for Hare"
HOMEPAGE="https://git.sr.ht/~yerinalexey/hare-gi"
LICENSE="MPL-2.0"

IUSE="+gtk3 +gtk4"
REQUIRED_USE="|| ( gtk3 gtk4 )"

DEPEND="
	>=dev-lang/hare-0.25.2
	>=dev-libs/glib-2.80.5[introspection]
	dev-libs/gobject-introspection
	dev-libs/atk[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	media-libs/harfbuzz[introspection]
	x11-libs/pango[introspection]
	gtk3? (
		x11-libs/gtk+:3[introspection]
	)
	gtk4? (
		gui-libs/gtk:4[introspection]
		media-libs/graphene[introspection]
	)
"

src_prepare() {
	default
	sed -i 's;^PREFIX = .*;PREFIX = /usr;' Makefile || die

	if ! use gtk3; then
		sed -i '/^install: /s;install-gtk3;;' Makefile || die
	fi
	if ! use gtk4; then
		sed -i '/^install: /s;install-gtk4;;' Makefile || die
	fi
}

src_compile() {
	emake hare-gi
	if use gtk3; then
		./scripts/generate-gtk3 || die
	fi
	if use gtk4; then
		./scripts/generate-gtk4 || die
	fi
	touch .gen || die
}
