# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="List Wayland toplevels"
HOMEPAGE="https://git.sr.ht/~leon_plickat/lswt/"
SRC_URI="https://git.sr.ht/~leon_plickat/lswt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/wayland-protocols"

src_install() {
	# Need to install to /usr instead of /usr/local
	# and the Makefile doens't handle DESTDIR properly
	emake PREFIX="${D}"/usr install
}
