# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Call audio routing daemon"
HOMEPAGE="https://gitlab.com/mobian1/callaudiod"
SRC_URI="https://gitlab.com/mobian1/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	dev-libs/glib:2
	media-libs/alsa-lib
	media-libs/libpulse[glib]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/gdbus-codegen"
