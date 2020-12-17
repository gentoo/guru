# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Upstream's tarballs are timestamped (https://todo.sr.ht/~sircmpwn/hg.sr.ht/33).
# This makes them impossible to validate, so every version has a live ebuild.

inherit meson
if [ "${PV}" = 9999 ]
then
	inherit mercurial
	EHG_REPO_URI="https://hg.sr.ht/~scoopta/${PN}"
else
	SRC_URI="https://hg.sr.ht/~scoopta/wofi/archive/v${PV}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Wofi is a launcher/menu program for wlroots based wayland compositors like sway"
HOMEPAGE="https://hg.sr.ht/~scoopta/wofi"
LICENSE="GPL-3"

DEPEND="
	dev-libs/wayland
	x11-libs/gtk+[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

RESTRICT="test mirror"

SLOT="0"
