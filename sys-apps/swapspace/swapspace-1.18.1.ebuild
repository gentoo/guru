# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="A fork of Jeroen T. Vermeulen's excellent dynamic swap space manager"
HOMEPAGE="https://github.com/Tookmund/Swapspace"
SRC_URI="https://github.com/Tookmund/Swapspace/releases/download/v${PV}/swapspace-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64"

src_configure() {
	econf --localstatedir="${EPREFIX}"/var
}

src_install() {
	default

	doman doc/swapspace.8
	systemd_dounit "${FILESDIR}"/swapspace.service
}
