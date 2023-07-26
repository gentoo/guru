# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare-ssh"
	SLOT="0"
else
	EGIT_COMMIT="9fe392eb4478dc26680c8c5c42deb87d192447db"
	MY_P="${PN}-${EGIT_COMMIT}"
	SRC_URI="https://git.sr.ht/~sircmpwn/hare-ssh/archive/${EGIT_COMMIT}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="SSH library for Hare"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hare-ssh"
LICENSE="MPL-2.0"

RDEPEND="dev-lang/hare"
DEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
