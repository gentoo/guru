# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare-compress"
	SLOT="0"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/hare-compress/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="Compression algorithms for Hare"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hare-compress"
LICENSE="MPL-2.0"
SLOT="0"

DEPEND=">=dev-lang/hare-0.25.2"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
