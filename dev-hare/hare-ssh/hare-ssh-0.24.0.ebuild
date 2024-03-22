# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare-ssh"
	SLOT="0"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/hare-ssh/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="SSH library for Hare"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hare-ssh"
LICENSE="MPL-2.0"

RDEPEND=">=dev-lang/hare-0.24.0"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
