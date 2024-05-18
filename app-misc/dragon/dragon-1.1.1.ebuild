# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Simple drag-and-drop source/sink for X and Wayland"
HOMEPAGE="https://github.com/mwh/dragon"
SRC_URI="https://github.com/mwh/dragon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=x11-libs/gtk+-3"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -e 's/\(`pkg-config --cflags .*`\) \(`pkg-config --libs .*`\)/\1 $(CFLAGS) \2 $(LDFLAGS)/' \
		-i Makefile || die "sed failed"
}

src_install() {
	emake PREFIX="${D}/usr/bin" install
	dodoc README
}
