# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A donut.c-inspired fetch tool that spins your distro logo in 3D."
HOMEPAGE="https://github.com/areofyl/fetch"
SRC_URI="https://github.com/areofyl/fetch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	einstalldocs
}
