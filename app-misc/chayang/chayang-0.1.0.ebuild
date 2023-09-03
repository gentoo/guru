# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Gradually dim the screen."
HOMEPAGE="https://git.sr.ht/~emersion/chayang"
SRC_URI="https://git.sr.ht/~emersion/chayang/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-v${PV}"
RESTRICT="mirror"

RDEPEND="dev-libs/wayland"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/wayland-protocols-1.14
	>=dev-util/wayland-scanner-1.14.91
	virtual/pkgconfig
"
