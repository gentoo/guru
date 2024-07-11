# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare-xml"
	SLOT="0"
else
	EGIT_COMMIT="82ad30e1143286417b12b00d45ee1a03330f117e"
	SRC_URI="https://git.sr.ht/~sircmpwn/hare-xml/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${EGIT_COMMIT}.tar.gz"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"
	SLOT="0/${PV}"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="XML support for Hare"
HOMEPAGE="https://git.sr.ht/~sircmpwn/hare-xml"

LICENSE="MPL-2.0"

DEPEND=">=dev-lang/hare-0.24.0"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
