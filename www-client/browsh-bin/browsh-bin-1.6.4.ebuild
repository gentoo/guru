# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="A fully-modern text-based browser, rendering to TTY and browsers"
HOMEPAGE="https://brow.sh"
SRC_URI="https://github.com/browsh-org/browsh/releases/download/v${PV}/browsh_${PV}_linux_amd64.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_configure() {
	unpack_deb "${DISTDIR}"/browsh_"${PV}"_linux_amd64.deb
}

src_install() {
	dobin "${WORKDIR}"/usr/local/bin/browsh
}
