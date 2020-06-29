# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/cyclopsian/${PN}"
case "${PV}" in
	"9999")
		inherit git-r3
		;;
	*)
		SRC_URI="${EGIT_REPO_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
esac
inherit meson xdg

DESCRIPTION="GUI display configurator for wlroots compositors"
HOMEPAGE="https://cyclopsian.github.io/${PN}"

BDEPEND="
	x11-libs/gtk+:3
	gui-libs/wlroots"
DEPEND="${BDEPEND}"

LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~amd64"
