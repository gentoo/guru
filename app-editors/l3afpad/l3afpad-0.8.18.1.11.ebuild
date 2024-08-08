# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg autotools

DESCRIPTION="Simple GTK3 text editor (successor to leafpad)"
HOMEPAGE="https://github.com/stevenhoneyman/l3afpad"
SRC_URI="https://github.com/stevenhoneyman/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

BDEPEND=""
DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		--enable-print \
		$(use_enable emacs)
}
