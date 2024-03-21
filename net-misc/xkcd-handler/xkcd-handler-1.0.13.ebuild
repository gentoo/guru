# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop

DESCRIPTION="A handler for XKCD urls"
HOMEPAGE="https://xkcd.com/"
SRC_URI="https://github.com/mazunki/xkcd/archive/refs/tags/v${PV}.tar.gz -> xkcd-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-misc/xdg-utils"

S="${WORKDIR}/xkcd-${PV}"

src_install() {
	dobin xkcd
	domenu xkcd.desktop
	doman xkcd.1
}
