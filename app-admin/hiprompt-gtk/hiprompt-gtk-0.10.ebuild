# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hiprompt-gtk"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/hiprompt-gtk/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GTK4 prompter for Himitsu"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hiprompt-gtk"
LICENSE="GPL-3"
SLOT="0"

COMMON_DEPEND="
	dev-libs/glib
	>=gui-libs/gtk-4.18:4
	gui-libs/libadwaita
	gui-libs/gtk4-layer-shell
"
DEPEND="
	${COMMON_DEPEND}
	>=dev-lang/hare-0.26.0:=
	app-admin/himitsu
	dev-hare/hare-gi
	dev-hare/hare-adwaita
	dev-hare/hare-gtk4-layer-shell
"
# gui-apps/hiprompt-gtk-py: both are installing to /usr/bin/hiprompt-gtk
RDEPEND="
	${COMMON_DEPEND}
	!gui-apps/hiprompt-gtk-py
"

# All binaries are hare-built
QA_FLAGS_IGNORED=".*"

src_configure() {
	export PREFIX=/usr
}
