# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="JSON support for Hare"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hare-json"
SRC_URI="https://git.sr.ht/~sircmpwn/hare-json/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MPL-2.0"
SLOT="0"

KEYWORDS="~amd64 ~arm64 ~riscv"

DEPEND=">=dev-lang/hare-0.24.2"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
