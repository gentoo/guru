# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A lightweight overlay volume (or anything) bar for the X Window System"
HOMEPAGE="https://github.com/florentc/xob"
SRC_URI="https://github.com/florentc/xob/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/libX11
	dev-libs/libconfig
"
DEPEND="${RDEPEND}"

src_install() {
	emake prefix="${EPREFIX}"/usr \
		  sysconfdir="${EPREFIX}"/etc \
		  DESTDIR="${D}" install
	dodoc CHANGELOG.md README.md
}
