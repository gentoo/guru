# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EHG_REPO_URI="https://hg.sr.ht/~scoopta/${PN}"
case "${PV}" in
	"9999")
		inherit mercurial
		;;
	*)
		SRC_URI="${EHG_REPO_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-v${PV}"
esac
inherit meson

DESCRIPTION="Wofi is a launcher/menu program for wlroots based wayland compositors like sway"
HOMEPAGE="${EHG_REPO_URI}"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS=""
