# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Upstream's tarballs are timestamped (https://todo.sr.ht/~sircmpwn/hg.sr.ht/33).
# This makes them impossible to validate, so every version has a live ebuild.

EHG_REPO_URI="https://hg.sr.ht/~scoopta/${PN}"
inherit meson mercurial
case "${PV}" in
	"9999")
		;;
	*)
		EHG_REVISION="v${PV}"
esac

DESCRIPTION="Wofi is a launcher/menu program for wlroots based wayland compositors like sway"
HOMEPAGE="${EHG_REPO_URI}"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS=""
